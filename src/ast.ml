(*
 * Copyright (c) 2012 - 2016, Prologin
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)


(**
   Ce module contient les différents AST de notre compilateur
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ext

type varname = | UserName of string
               | InternalName of int

let get_username = function
  | UserName s -> Some s
  | InternalName _ -> None

let debug_varname f = function
  | UserName s -> Format.fprintf f "UserName %S" s
  | InternalName i -> Format.fprintf f "InternalName %d" i

type typename = string
type funname = string
type fieldname = string

module BindingStruct = struct
  type t = varname
  let compare a b = match a, b with
    | UserName v1, UserName v2 -> String.compare v1 v2
    | InternalName i1, InternalName i2 -> i1 - i2
    | InternalName _, UserName _ -> 1
    | UserName _, InternalName _ -> -1
end

module BindingSet = MakeSet(BindingStruct)
module BindingMap = MakeMap(BindingStruct)

(** returns the next value *)
let next =
  let r = ref 0 in
  fun () ->
    let out = !r in
    begin
      r := (out + 1);
      out
    end

(** {2 Positions} *)
(** the position in a file :
    ((a, b), (c, d)) means from line a char b to line c char d
*)
module Location : sig
  type t
  type p
  val default: t
  val parsed_file : string ref
  val makep : int -> int -> p
  val merge : t -> t -> t
  val make : p -> p -> t
  val pp : Format.formatter -> t -> unit
end = struct
  type p = int * int
  type t = ( string * p * p )
  let default = "No File", (-1, -1), (-1, -1)
  let parsed_file = ref ""
  (** get a position from lexer (line, char) *)
  let makep line cnum = line, cnum
  let merge (f, a, _) (f2, _, b) = (f, a, b)
  (** get a location from lexer *)
  let make p1 p2 = (!parsed_file, p1, p2)
    
  let pp f (file, (l1, c1), (l2, c2)) =
    if l1 = l2 then Format.fprintf f "(on %s:%d:%d-%d)" file l1 c1 c2
    else Format.fprintf f "(file %s from %d:%d to %d:%d)" file l1 c1 l2 c2

end

  
(** position map *)
module PosMap : sig
  val add : int -> Location.t -> unit
  val get : int -> Location.t
  val mem : int -> bool
end = struct
  let map = ref IntMap.empty
  let mem i = IntMap.mem i !map
  let add i l =
    map := IntMap.add i l !map
  let get i =
    try
      IntMap.find i !map
    with Not_found -> Location.default
end

(** {2 Modules d'AST} *)

(** lexems modules
    this module contains macro definitions
*)
module Lexems = struct

  type ('lexem, 'expr, 'token) tofix =
    | Expr of 'expr
    | Token of 'token
    | UnQuote of 'lexem list

  module P = struct
    let next () = next ()
    type ('a, 'b, 'c) alias = ('a, 'b, 'c) tofix
    type _ tofix = T : ('a, 'b, 'c) alias -> ( 'a * ('b * ('c * 'z))) tofix
    module Make(App:Applicative) = struct
      open App
      include ListApp(App)
      include MKArrow(App)

      let foldmap0 f g h = function
        | Expr e -> ret (fun e -> ( Expr e)) <*> g e
        | Token t -> ret (fun t ->  (Token t)) <*> h t
        | UnQuote li -> ret (fun li ->  (UnQuote li)) <*> fold_left_map f li

      let foldmap : type a b . (a, b) arrow -> a tofix -> b tofix App.t = fun arr (T x) ->
        match arr with
        | Id -> App.ret (T x)
        | Arrow (f, Id) -> App.ret (fun x -> T x) <*> foldmap0 f App.ret App.ret x
        | Arrow (f, Arrow (g, Id)) -> App.ret (fun x -> T x) <*> foldmap0 f g App.ret x
        | Arrow (f, Arrow (g, Arrow (h, Id))) -> App.ret (fun x -> T x) <*> foldmap0 f g h x
    end 
  end
  module Fixed = FixN(P)
  type void
  type ('lex, 'expr) t = ('expr * ('lex * void)) Fixed.t
  let fix x = Fixed.fix (P.T x)
  let unfix x = match Fixed.unfix x with P.T x -> x

  let token t = fix (Token t)
  let unquote li = fix( UnQuote li)

end


let punitlist f li =
  Format.fprintf f "[@[%a@]]"
    (Printers.print_list (fun f i -> i f ()) (fun f -> Format.fprintf f "%a;@ %a")) li

(**
   mutable module
   this module contains mutable values like array, records and variables
*)
module Mutable = struct

  (** {2 type} *)

  type ('mutable_, 'expr) tofix =
      Var of varname
    | Array of 'mutable_ * 'expr list
    | Dot of 'mutable_ * fieldname

  let pdebug f = function
    | Var v -> Format.fprintf f "Var (%a)" debug_varname v
    | Array (m, li) -> Format.fprintf f "Array (%a, [%a])" m () punitlist li
    | Dot (m, fi) -> Format.fprintf f "Dot(%a, %s)" m () fi

  (** {2 Parcours} *)
  module Fixed = Fix2( struct
      let next () = next ()
      type ('a, 'b) alias = ('a, 'b) tofix
      type ('a, 'b) tofix = ('a, 'b) alias
      module Make(F:Applicative) = struct
        open F
        include ListApp(F)
        let foldmap f g t =
          match t with
          | Var v -> ret ( Var v )
          | Array (v, el) -> ret (fun v el -> Array(v, el)) <*> f v <*> fold_left_map g el
          | Dot (v, field) -> ret (fun v -> Dot(v, field)) <*> f v
      end
    end)

  type 'expr t = 'expr Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  (** module de réécriture et de parcours d'AST *)
  module Writer = AstWriter.F (struct
      type 'a alias = 'a t
      type 'a t = 'a alias
      let foldmap f acc t = Fixed.Surface.foldmapt (fun x acc -> f acc x) t acc
    end)

  let rec equals cmpe a b = match (unfix a, unfix b) with
    | Var v1, Var v2 ->
      begin match (v1, v2) with
        | InternalName i1, InternalName i2 -> i1 = i2
        | UserName v1, UserName v2 -> String.equals v1 v2
        | _ -> false
      end
    | Array (m1, li1), Array (m2, li2) ->
      if equals cmpe m1 m2 then List.zip li1 li2 |> List.forall
                                  (uncurry cmpe)
      else false
    | Dot (m1, field1), Dot (m2, field2) ->
      if equals cmpe m1 m2 then String.equals field1 field2
      else false
    | _ -> false

  (** {2 utils} *)

  let array a el = Array (a, el) |> Fixed.fix
  let var a = Var a |> Fixed.fix
  let dot a f = Dot (a, f) |> Fixed.fix

end

(**
   type module
   this module contains ast for metalang types
*)
module Type = struct

  type 'a tofix =
    | Integer
    | String
    | Char
    | Array of 'a
    | Void
    | Bool
    | Lexems
    | Struct of (fieldname * 'a) list
    | Enum of fieldname list
    | Named of typename
    | Tuple of 'a list
    | Option of 'a
    | Auto

  module Fixed = Fix2(struct
      type 'a alias = 'a tofix
      type ('a, _) tofix = 'a alias
      let next () = next ()
      module Make(F:Applicative) = struct
        open F
        include ListApp(F)
        let foldmap f g e =
          let f' (a, x) = ret (fun x -> a, x) <*> f x in
          match e with
          | Auto -> ret Auto
          | Integer -> ret Integer
          | String -> ret String
          | Void -> ret Void
          | Bool -> ret Bool
          | Lexems -> ret Lexems
          | Named n -> ret (Named n)
          | Enum e -> ret (Enum e)
          | Char -> ret Char
          | Option t -> ret (fun x -> Option x) <*> f t
          | Array t -> ret (fun x -> Array x) <*> f t
          | Tuple li -> ret (fun li -> Tuple li) <*> fold_left_map f li
          | Struct li -> ret (fun li -> Struct li) <*>  fold_left_map f' li
      end
    end)

  type t = unit Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  let rec compare (ta : t) (tb : t) : int =

    match (unfix ta), (unfix tb) with
    | Auto, Auto -> 0
    | Auto, _ -> -1
    | Lexems, Lexems -> 0
    | Lexems, Auto -> 1
    | Lexems, _ -> -1
    | Integer, Integer -> 0
    | Integer, (Lexems | Auto) -> 1
    | Integer, _ -> -1
    | String, String -> 0
    | String, (Auto | Lexems | Integer) -> 1
    | String, _ -> -1
    | Char, Char -> 0
    | Char, (Auto | Lexems | Integer | String) -> 1
    | Char, _ -> -1
    | Array ca, Array cb -> compare ca cb
    | Array _, (Char | Auto | Lexems | Integer | String) -> 1
    | Array _, _ -> -1
    | Option ca, Option cb -> compare ca cb
    | Option _, (Array _ | Char | Auto | Lexems | Integer | String) -> 1
    | Option _, _ -> -1
    | Void, Void -> 0
    | Void, (Array _ | Char | Auto | Lexems | Integer | String) -> 1
    | Void, _ -> -1
    | Bool, Bool -> 0
    | Bool, (Void | Array _ | Char | Auto | Lexems | Integer | String) -> 1
    | Bool, _ -> -1
    | Enum _, (Bool | Void | Array _ | Char | Auto | Lexems | Integer | String) -> 1
    | Enum e1, Enum e2 ->
      let l1 = List.length e1
      and l2 = List.length e2 in
      if l1 = l2 then
        List.fold_left (fun result (n1, n2) ->
            if result <> 0 then result else
              String.compare n1 n2
          ) 0 (List.combine e1 e2)
      else l1 - l2
    | Enum _, _ -> -1

    | Struct s1, Struct s2 ->
      let l1 = List.length s1
      and l2 = List.length s2 in
      if l1 = l2 then
        List.fold_left (fun result ((n1, t1), (n2, t2)) ->
            if result <> 0 then result else
              let result = String.compare n1 n2 in
              if result <> 0 then result else
                compare t1 t2
          ) 0 (List.combine s1 s2)
      else l1 - l2
    | Tuple li1, Tuple li2 ->
      let len1 = List.length li1 and
      len2 = List.length li2 in
      if len1 < len2 then -1
      else if len2 < len1 then 1
      else List.fold_left (fun acc (t1, t2) ->
          if acc = 0 then compare t1 t2
          else acc
        ) 0 (List.combine li1 li2)
    | Tuple _, _ -> 1
    | Struct _, (Enum _| Bool | Void | Array _ | Char | Auto |
                 Lexems | Integer | String) -> 1
    | Struct _, _ -> -1
    | Named n1, Named n2 -> String.compare n1 n2
    | Named _, (Enum _| Struct _ | Bool | Void | Array _ | Char |
                Auto | Lexems | Integer | String | Tuple _ | Option _) -> 1

  let type2String = function
    | Auto -> "Auto"
    | Integer -> "Integer"
    | String -> "String"
    | Char -> "Char"
    | Array t -> "Array("^t^")"
    | Void -> "Void"
    | Bool -> "Bool"
    | Lexems -> "Lexems"
    | Option t -> "Option("^t^")"
    | Tuple li ->
      let str = List.fold_left
          (fun acc t ->
             acc ^ ", " ^ t
          ) "" li
      in "("^str^")"
    | Enum e -> let str = List.fold_left
                    (fun acc name ->
                       acc ^ name ^ ", "
                    ) "" e
      in "Enum("^str^")"
    | Struct li ->
      let str = List.fold_left
          (fun acc (name, t) ->
             acc ^ name ^ ":"^t^"; "
          ) "" li
      in "Struct("^str^")"
    | Named t -> "Named("^t^")"

  let type_t_to_string t = Fixed.Deep.fold type2String t

  let bool:t = Bool |> fix
  let integer:t = Integer |> fix
  let void:t = Void |> fix
  let string:t = String |> fix
  let char:t = Char |> fix
  let array t = Array t |> fix
  let option t = Option t |> fix
  let enum s = Enum (s) |> fix
  let struct_ s = Struct s |> fix
  let named n = Named n |> fix
  let tuple n = Tuple n |> fix
  let auto () = Auto |> fix
  let lexems:t = Lexems |> fix

end

module TypeMap = MakeMap (Type)
module TypeSet = MakeSet (Type)


(**
   expr module
   this module contains ast for metalang expressions
*)
module Expr = struct


  (** {2 types} *)

  (** unary operators *)
  type unop =
      Neg (** integer *)
    | Not (** boolean *)

  let pdebug_unop f op = Format.fprintf f (match op with
      | Neg -> "Neg" | Not -> "Not")

  (** binary operators *)
  type binop =
    | Add | Sub | Mul | Div (* int *)
    | Mod (* int *)
    | Or | And (* bool *)
    | Lower | LowerEq | Higher | HigherEq (* 'a *)
    | Eq | Diff (* 'a *)

  let pdebug_binop f op = Format.fprintf f (match op with
      | Add -> "Add" | Sub -> "Sub" | Mul -> "Mul"
      | Div -> "Div" | Mod -> "Mod" | Or -> "Or" | And -> "And"
      | Lower -> "Lower" | LowerEq -> "LowerEq" | Higher -> "Higher" | HigherEq -> "HigherEq"
      | Eq -> "Eq" | Diff -> "Diff")

  type lief =
    | Char of char
    | String of string
    | Integer of int
    | Bool of bool
    | Enum of string (** enumerateur *)
    | Nil

  let pdebug_lief f = let open Format in function
      | Char c -> fprintf f "Char %C" c
      | String s -> fprintf f "String %S" s
      | Integer i -> fprintf f "Integer %i" i
      | Bool b -> fprintf f "Bool %b" b
      | Enum s -> fprintf f "Enum %S" s
      | Nil -> fprintf f "Nil"

  type ('a, 'lex) tofix =
      BinOp of 'a * binop * 'a (** operations binaires *)
    | UnOp of 'a * unop (** operations unaires *)
    | Lief of lief
    | Access of 'a Mutable.t (** vaut la valeur du mutable *)
    | Call of funname * 'a list (** appelle la fonction *)
    | Lexems of ('lex, 'a) Lexems.t list (** contient un bout d'AST *)
    | Tuple of 'a list
    | Record of (fieldname * 'a) list
    | Just of 'a

  let rec equals0 cmpa cmplex a b =
    let rec cmpli li1 li2 = match li1, li2 with
      | [], [] -> true
      | hd1::tl1, hd2::tl2 -> cmpa hd1 hd2 && cmpli tl1 tl2
      | _ -> false
    in
    match a, b with
    | BinOp (a1, op1, b1), BinOp (a2, op2, b2) -> op1 = op2 && cmpa a1 a2 && cmpa b1 b2
    | UnOp (a1, op1), UnOp (a2, op2) -> op1 = op2 && cmpa a1 a2
    | Lief l1, Lief l2 -> l1 = l2
    | Access m1, Access m2 -> Mutable.equals cmpa m1 m2
    | Call (name1, li1), Call (name2, li2) -> String.equals name1 name2 && cmpli li1 li2
    | Lexems _, Lexems _ -> assert false (* TODO *)
    | Tuple li1, Tuple li2 -> cmpli li1 li2
    | Record li1, Record li2 -> cmpli (List.map snd li1) (List.map snd li2)
    | Just e1, Just e2 -> cmpa e1 e2
    | _ -> false

  let pdebug f = function
    | BinOp(a, op, b) -> Format.fprintf f "E.BinOp(%a, %a, %a)" a () pdebug_binop op b ()
    | UnOp(a, unop) -> Format.fprintf f "E.UnOp(%a, %a)" a () pdebug_unop unop
    | Lief l -> Format.fprintf f "E.Lief(%a)" pdebug_lief l
    | Access mut ->
      let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
      Format.fprintf f "E.Access(%a)" mut ()
    | Call (name, li) -> Format.fprintf f "E.Call(%S, %a)" name punitlist li
    | Lexems li -> assert false (* TODO *)
    | Tuple li -> Format.fprintf f "E.Tuple(%a)" punitlist li
    | Record li -> Format.fprintf f "E.Record(%a)" punitlist (List.map (fun (field, e) f () ->
        Format.fprintf f "(%S, %a)" field e ()) li)
    | Just a -> Format.fprintf f "E.Just(%a)" a ()

  (** {2 parcours} *)

  module Fixed = Fix2(struct
      type ('a,'b) alias = ('a, 'b) tofix
      type ('a, 'b) tofix = ('a, 'b) alias
      let next () = next ()
      module Make(F:Applicative) = struct
        open F
        module Mut = Mutable.Fixed.Apply(F)
        module Lex = Lexems.Fixed.Apply(F)
        include ListApp(F)
        module Arrow = MKArrow(F)

        let foldmap f g t = match t with
          | BinOp (a, op, b) -> ret (fun a b -> BinOp (a, op, b)) <*> f a <*> f b
          | UnOp (a, op) -> ret (fun a -> UnOp(a, op)) <*> f a
          | Lief l -> ret (Lief l)
          | Call (n, li) -> ret (fun x ->  Call (n, x)) <*> fold_left_map f li
          | Tuple e -> ret (fun e -> Tuple e)  <*> fold_left_map f e
          | Record li ->
            let f' (a, x) = ret (fun x -> a, x) <*> f x in
            ret (fun e -> Record e) <*>  fold_left_map f' li
          | Access m ->
            ret (fun m -> Access m) <*> Mut.map f m
          | Lexems x -> ret (fun x -> Lexems x) <*> fold_left_map
                          (Lex.map (Arrow.carrow f (Arrow.arrow g))) x
          | Just x -> ret (fun x -> Just x) <*> f x
      end
    end)

  type 'a t = 'a Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  let rec equals e1 e2 = equals0 equals (=) (unfix e1) (unfix e2)

  let pdebug_deep f e = Fixed.Deep.fold (fun e f () -> pdebug f e) e f ()

  let add_bindings x =
    Fixed.Deep.fold
      (function
        | Access m ->
          Mutable.Fixed.Deep.fold (function
              | Mutable.Var v -> (fun acc -> BindingSet.add v acc)
              | x -> Mutable.Fixed.Surface.fold (fun a b -> a @* b) (fun x -> x) x
            ) m
        | x -> (fun acc -> Fixed.Surface.fold (fun acc f -> f acc) acc x)
      ) x
  let bindings x = add_bindings x BindingSet.empty

  (** module de réécriture et de parcours d'AST *)
  module Writer = AstWriter.F (struct
      type 'a alias = 'a t
      type 'a t = 'a alias
      let foldmap f acc t = Fixed.Surface.foldmapt (fun x acc -> f acc x) t acc
    end)

  (** {2 utils} *)

  let lief l = fix (Lief l)
  let bool b = lief (Bool b)

  let nil () = lief Nil
  let just x = fix (Just x)

  let enum e = lief (Enum e)

  let unop op a = fix (UnOp (a, op))
  let binop op a b = fix (BinOp (a, op, b))

  let integer i = lief (Integer i)
  let char i = lief (Char i)
  let string f = lief (String f)

  let lexems li = fix (Lexems li)

  let access m = fix (Access m )
  let tuple li = fix (Tuple li )
  let record li = fix (Record li )

  let add e1 e2 = binop Add e1 e2
  let sub e1 e2 = binop Sub e1 e2
  let mul e1 e2 = binop Mul e1 e2
  let div e1 e2 = binop Div e1 e2

  let call name li = fix ( Call(name, li))

  let is_integer i e = match unfix e with
    | Lief (Integer i2) when i = i2 -> true
    | _ -> false

  let saddi a b = match unfix a with
    | BinOp (a, Sub, c) when is_integer b c -> a
    | _ -> binop Add a (integer b)

end

(**
   instructions metalang
*)
module Instr = struct

  type declaration_option =
    {
      useless : bool;
    }

  let default_declaration_option =
    {
      useless = false
    }

  let useless_declaration_option =
    {
      useless = true
    }

  let popt f opt =
    Format.fprintf f "{useless=%b}" opt.useless

  type 'expr printable =
    | StringConst of string
    | PrintExpr of Type.t * 'expr

  type 'expr readable =
    | Separation
    | ReadExpr of Type.t * 'expr Mutable.t
    | DeclRead of Type.t * varname * declaration_option

  type ('a, 'expr) tofix =
      Declare of varname * Type.t * 'expr * declaration_option
    | Affect of 'expr Mutable.t * 'expr
    | SelfAffect of 'expr Mutable.t * Expr.binop * 'expr
    | Incr of 'expr Mutable.t
    | Decr of 'expr Mutable.t        
    | Loop of varname * 'expr * 'expr * 'a list
    | ClikeLoop of 'a list * 'expr * 'a list * 'a list
    | While of 'expr * 'a list
    | Comment of string
    | Tag of string
    | Return of 'expr
    | AllocArray of varname * Type.t * 'expr * (varname * 'a list) option * declaration_option
    | AllocArrayConst of varname * Type.t * 'expr * Expr.lief * declaration_option
    | AllocRecord of varname * Type.t * (fieldname * 'expr) list * declaration_option
    | If of 'expr * 'a list * 'a list
    | Call of funname * 'expr list
    | Print of 'expr printable list
    | Read of 'expr readable list
    | Untuple of (Type.t * varname) list * 'expr * declaration_option
    | Unquote of 'expr

  let pdebug f = let open Format in function
      | Declare (va, ty, e, opt) -> fprintf f "I.Declare(%a, %s, %a, %a)"
                                      debug_varname va
                                      (Type.type_t_to_string ty)
                                      e ()
                                      popt opt
      | Affect (mut, e) ->
        let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
        fprintf f "I.Affect(%a, %a)" mut () e ()
      | SelfAffect (mut, op, e) ->
        let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
        fprintf f "I.SelfAffect(%a, %a, %a)" mut () Expr.pdebug_binop op e ()
      | Incr mut ->
        let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
        fprintf f "I.Incr(%a)" mut ()
      | Decr mut ->
        let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
        fprintf f "I.Decr(%a)" mut ()
      | Loop (var, e1, e2, li) ->
        fprintf f "I.Loop(%a, %a, %a, %a)"
          debug_varname var e1 () e2 () punitlist li
      | ClikeLoop (init, cond, incr, li) -> fprintf f "I.ClikeLoop(%a, %a, %a, %a)" punitlist init cond () punitlist incr punitlist li
      | While (e, li) -> fprintf f "I.While(%a, %a)" e () punitlist li
      | Comment(s) -> fprintf f "I.Comment(%S)" s
      | Tag(s) -> fprintf f "I.Tag(%S)" s
      | Return(e) -> fprintf f "I.Return(%a)" e ()
      | AllocArray(name, ty, e, None, opt) ->
        fprintf f "I.AllocArray(%a, %s, %a, None, %a)"
          debug_varname name (Type.type_t_to_string ty) e ()
          popt opt
      | AllocArray(name, ty, e, Some(name2, li), opt) ->
        fprintf f "I.AllocArray(%a, %s, %a, Some(%a, %a), %a)"
          debug_varname name (Type.type_t_to_string ty) e ()
          debug_varname name2 punitlist li popt opt
      | AllocArrayConst(name, ty, e, lief, opt) ->
        fprintf f "I.AllocArrayConst(%a, %s, %a, %a, %a)" debug_varname name
          (Type.type_t_to_string ty) e ()
          Expr.pdebug_lief lief popt opt
      | AllocRecord(name, ty, li, opt) -> fprintf f "I.AllocRecord(%a, %s, %a, %a)"
                                            debug_varname name (Type.type_t_to_string ty)
                                            punitlist (List.map (fun (a, b) f () -> fprintf f "(%S,@ %a)" a b () ) li) popt opt
      | If(e, a, b) -> fprintf f "I.If(@[%a,@\n%a,@\n%a@])" e () punitlist a punitlist b
      | Call(name, li) -> fprintf f "I.Call(%S, %a)" name punitlist li
      | Print li -> fprintf f "I.Print(%a)"
                      punitlist
                      (List.map (fun e f () -> match e with
                           | StringConst s -> fprintf f "%S" s
                           | PrintExpr (ty, e) -> fprintf f "Expr(%s, %a)" (Type.type_t_to_string ty) e ()) li)
      | Read li ->
        fprintf f "I.Read(%a)"
          punitlist
          (List.map (fun e f () -> match e with
               | Separation -> fprintf f "Sep"
               | DeclRead(ty, name, opt) ->
                 fprintf f "I.DeclRead(%s, %a, %a)" (Type.type_t_to_string ty)
                   debug_varname name popt opt
               | ReadExpr (ty, mut) ->
                 let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
                 fprintf f "I.Mut(%s, %a)" (Type.type_t_to_string ty) mut ()) li)
      | Untuple(li, e, opt) -> fprintf f "I.Untuple(%a, %a, %a)"
                                 punitlist (List.map (fun (ty, name) f () -> fprintf f "(%s,@ %a)"
                                                         (Type.type_t_to_string ty)
                                                         debug_varname name) li)
                                 e () popt opt
      | Unquote(e) -> fprintf f "I.Unquote(%a)" e ()

  module Make(F:Applicative) = struct
    open F
    module Mut = Mutable.Fixed.Apply(F)
    include ListApp(F)
    let foldmap_bloc f g t =
      let g' (a, x) = ret (fun x -> a, x) <*> g x in
      match t with
      | Declare (a, b, c, d) -> ret (fun c -> Declare (a, b, c, d)) <*> g c 
      | Affect (m, e) -> ret (fun m e -> Affect (m, e)) <*> Mut.map g m <*> g e
      | SelfAffect (m, op, e) -> ret (fun m e -> SelfAffect (m, op, e)) <*> Mut.map g m <*> g e
      | Incr (m) -> ret (fun m -> Incr (m)) <*> Mut.map g m
      | Decr (m) -> ret (fun m -> Decr (m)) <*> Mut.map g m
      | Comment s -> ret (Comment s)
      | Loop (var, e1, e2, li) -> ret (fun e1 e2 li -> Loop (var, e1, e2, li)) <*> g e1 <*> g e2 <*> f li
      | ClikeLoop (i1, e, i2, i3) -> ret (fun i1 e i2 li3 -> ClikeLoop(i1, e, i2, li3)) <*> f i1 <*> g e <*> f i2 <*> f i3
      | While (e, li) -> ret (fun e li -> While (e, li)) <*> g e <*> f li 
      | If (e, cif, celse) -> ret (fun e cif celse -> If (e, cif, celse)) <*> g e <*> f cif <*> f celse
      | Return e -> ret (fun e -> Return e) <*> g e
      | AllocArray (b, t, l, Some ((b2, li)), opt) -> ret (fun l li -> AllocArray (b, t, l, Some((b2, li)), opt)) <*> g l <*> f li
      | AllocArray (a, b, c, None, opt) -> ret (fun c -> AllocArray (a, b, c, None, opt)) <*> g c
      | AllocRecord (a, b, c, opt) -> ret (fun c -> AllocRecord (a, b, c, opt)) <*> fold_left_map g' c
      | Print li -> ret (fun l -> Print l) <*>
                    fold_left_map (function
                        | StringConst s -> ret (StringConst s)
                        | PrintExpr (ty, e) -> ret (fun e -> PrintExpr (ty, e)) <*> g e) li
      | Read li -> ret (fun l -> Read l) <*>
                   fold_left_map (function
                       | Separation -> ret Separation
                       | DeclRead (a, b, opt) -> ret (DeclRead (a, b, opt))
                       | ReadExpr (ty, mut) -> ret (fun m -> ReadExpr (ty, m)) <*> Mut.map g mut) li
      | Call (a, b) -> ret (fun b -> Call (a, b)) <*> fold_left_map g b
      | Unquote e -> ret (fun e -> Unquote e) <*> g e
      | Untuple (lis, e, opt) -> ret (fun e -> Untuple (lis, e, opt)) <*> g e
      | Tag e -> ret (Tag e)
      | AllocArrayConst (v, t, e1, e2, d) -> ret (fun e1 -> AllocArrayConst (v, t, e1, e2, d)) <*> g e1
    let foldmap f g t = foldmap_bloc (fold_left_map f) g t   
  end
  module Fixed = Fix2(struct
      type ('a,'b) alias = ('a, 'b) tofix
      type ('a, 'b) tofix = ('a, 'b) alias
      let next () = next ()
      module Make = Make
    end)

  type 'a t = 'a Fixed.t
  let fixa = Fixed.fixa
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  let pdebug_exprinstr f i =
    Fixed.Deep.fold2_bottomup (fun i f () -> pdebug f i) (fun e f () -> Expr.pdebug_deep f e) i f ()
  let debug_shape f i = pdebug f (Fixed.Surface.map2 (fun _ _ () -> ()) (fun _ _ () -> ()) i)


  let add_bindings (x: 'a Expr.t t) =
    let fli li acc = List.fold_left (fun acc f -> f acc) acc li in
    let mut = Mutable.Fixed.Deep.foldg (fun e acc -> e acc) in
    Fixed.Deep.fold2_bottomup
      (function
        | Declare (n, _, e, _)
        | AllocArray (n, _, e, None, _)
        | AllocArrayConst (n, _, e, _, _) ->  e @* BindingSet.add n
        | Affect (m, e) | SelfAffect (m, _, e) -> e @* mut m
        | Incr m | Decr m -> mut m
        | Loop (v, e, f, li) -> e @* f @* BindingSet.add v @* fli li
        | ClikeLoop (init, cond, incr, li) -> cond @* fli init @* fli incr @* fli li
        | While (e, li) -> e @* fli li
        | Comment _
        | Tag _ -> (fun acc -> acc)
        | AllocArray (n, _, e, Some (n2, li), _) -> e @* BindingSet.add n @* BindingSet.add n2 @* fli li
        | AllocRecord (n, _, li, _) ->BindingSet.add n @* fli (List.map snd li)
        | If (e, l1, l2) -> e @* fli l1 @* fli l2
        | Call (_, eli) -> fli eli
        | Return e -> e
        | Print li ->
          fun acc0 -> List.fold_left
              (fun acc -> function
                 | StringConst _ -> acc
                 | PrintExpr (_, e) -> e acc) acc0 li
        | Read li ->
          fun acc0 -> List.fold_left
              (fun acc -> function
                 | Separation -> acc
                 | DeclRead (_, v, _) -> BindingSet.add v acc
                 | ReadExpr (ty, m) -> mut m acc) acc0 li
        | Untuple (li, e, _) -> e @* (fun acc -> List.fold_left (fun acc (_, v) -> BindingSet.add v acc) acc li)
        | Unquote e -> e
      )
      Expr.add_bindings x

  let bindings x = add_bindings x BindingSet.empty

  let fold_map_bloc (type acc) f ac t =
    let module A = Applicatives.FoldMap(struct type t = acc end) in
    let module M = Make(A) in
    M.foldmap_bloc (fun a acc -> f acc a) A.ret t ac

  let map_bloc f t =
    let module A = Applicatives.Map in
    let module M = Make(A) in
    M.foldmap_bloc f A.ret t

  let rec deep_map_bloc f t =
    map_bloc (
      f @* List.map (fun i ->
          let annot = Fixed.annot i in
          let i = deep_map_bloc f (unfix i) in
          (Fixed.fixa annot i)
        )) t

  let stdin_sep () = Read [Separation] |> fix
  let print t v =
    match Type.unfix t, Expr.unfix v with
    | (Type.String | Type.Auto), Expr.Lief (Expr.String str) -> Print  [ StringConst str] |> fix
    | _ -> Print [PrintExpr (t, v)] |> fix
  let read t v = Read [ReadExpr (t, v)] |> fix
  let readdecl t v opt = Read [DeclRead (t, v, opt)] |> fix
  let call v p = Call (v, p) |> fix
  let declare v t e opt =  Declare (v, t, e, opt) |> fix
  let affect v e = Affect (v, e) |> fix
  let unquote e = Unquote e |> fix
  let loop v e1 e2 li = Loop (v, e1, e2, li) |> fix
  let while_ e li = While (e, li) |> fix
  let comment s = Comment s |> fix
  let tag s = Tag s |> fix
  let return e = Return e |> fix
  let untuple li e opt = Untuple (li, e, opt) |> fix
  let alloc_array binding t len opt =
    AllocArray(binding, t, len, None, opt) |> fix
  let alloc_record binding t fields opt =
    AllocRecord(binding, t, fields, opt) |> fix
  let alloc_array_lambda binding t len b e opt =
    AllocArray(binding, t, len, Some ( (b, e) ), opt ) |> fix
  let alloc_array_lambda_opt binding t len lambda opt =
    AllocArray(binding, t, len, lambda, opt ) |> fix
  let if_ e cif celse =
    If (e, cif, celse) |> fix

  (** module de réécriture et de parcours d'AST *)
  module Writer = AstWriter.F (struct
      type 'a alias = 'a t
      type 'a t = 'a alias
      let foldmap f acc t = Fixed.Surface.foldmapt (fun x acc -> f acc x) t acc
    end)
end

module Prog = struct

  type declaration_option =
    {
      useless : bool;
    }

  let default_declaration_option =
    {
      useless = false
    }

  let useless_declaration_option =
    {
      useless = true
    }

  type 'lex t_fun =
      DeclarFun of funname * Type.t *
                   ( varname * Type.t ) list * 'lex Expr.t Instr.t list * declaration_option
    | DeclareType of typename * Type.t
    | Macro of funname * Type.t * (string * Type.t) list * (string * string) list
    | Comment of string
    | Unquote of 'lex Expr.t

  let unquote u = Unquote u
  let comment s = Comment s
  let declarefun var t li1 li2 opt = DeclarFun (var, t, li1, li2, opt)
  let macro var t params li = Macro (var, t, params, li)

  (** global programm type :
      values of this type contains a full metalang programm *)
  type 'lex t =
    {
      progname : string;
      funs : 'lex t_fun list;
      main : 'lex Expr.t Instr.t list option;
      reads : TypeSet.t;
      hasSkip : bool;
    }

end

type 'a expr = 'a Expr.t
type 'a instr = 'a Expr.t Instr.t
