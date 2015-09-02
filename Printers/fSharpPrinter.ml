(*
 * Copyright (c) 2015, Prologin
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
 *)

(** FSharp Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast

let print_lief f l =
  let open Ast.Expr in let open Format in match l with
  | Char c -> fprintf f "%C" c
  | String s -> fprintf f "%S" s
  | Integer i -> fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%s" s

let prio_arg = -105
let prio_tuple = -103
let prio_apply = -101

let print_expr refbindings macros e f p =
  let open Format in
  let open Ast.Expr in
  let print_op f op = fprintf f "%s" (match op with
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "%"
  | Or -> "||"
  | And -> "&&"
  | Lower -> "<"
  | LowerEq -> "<="
  | Higher -> ">"
  | HigherEq -> ">="
  | Eq -> "="
  | Diff -> "<>") in
  let print_mut0 m f () =
    let open Mutable in match m with
    | Var v ->
        if BindingSet.mem v refbindings
        then fprintf f "(!%a)" print_varname v
        else print_varname f v
    | Array (m, fi) -> fprintf f "%a%a" m ()
          (print_list (fun f a -> fprintf f ".[%a]" a nop) (sep "%a%a")) fi
    | Dot (m, field) -> fprintf f "%a.%s" m () field in
  let print_mut f m = Mutable.Fixed.Deep.fold print_mut0 m f in
  let print_expr0 e f prio_parent = match e with
  | BinOp (a, op, b) ->
      let prio, priol, prior = prio_binop op in
      parens prio_parent prio f "%a %a %a" a priol print_op op b prior
  | UnOp (a, op) ->
      parens prio_arg prio_apply f "%s %a" (OcamlFunPrinter.unopstr op) a prio_arg

  | Lief l -> print_lief f l
  | Access m -> print_mut f m ()
  | Call (func, li) ->
      begin match StringMap.find_opt func macros with
      | Some ( (t, params, code) ) ->
          pmacros f "%s" t params code li nop
      | None ->
          if li = [] then parens prio_parent prio_apply f "%s ()" func
          else parens prio_parent prio_apply f "%s %a" func (print_list (fun f x -> x f prio_arg) sep_space) li
      end
  | Lexems li -> assert false
  | Tuple li -> fprintf f "(%a)" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
      fprintf f "%s=%a" name x nop) (sep "%a;@\n%a")) li

  in Fixed.Deep.fold print_expr0 e f p


let collect_return acc li =
  let f f acc i = match Instr.unfix i with
  | Instr.Return e -> IntSet.add (Expr.Fixed.annot e) acc
  | Instr.AllocArray _ -> acc
  | _ -> f acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f)) acc li

(** returns true if a list of instructions contains a return *)
let contains_return li =
  let f f acc i = match Instr.unfix i with
  | Instr.Return e -> true
  | Instr.AllocArray _ -> acc
  | _ -> f acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f)) false li

let nocomment li =
  List.filter (fun i -> match Instr.unfix i with
  | Instr.Comment _ -> false
  | _ -> true ) li

(** returns true if a list of instructions contains a return that
    ocaml cannot execute (it's compiled into an exception) *)
let rec collect_sad_return acc instrs =
  let rec f tra acc i = match Instr.unfix i with
    | Instr.AllocArray _ -> acc (* c'est interdit par d'autres passes *)
    | Instr.Loop(_, _, _, li) -> collect_return acc li
    | Instr.While (_, li) -> collect_return acc li
    | Instr.If (_, li1, li2) ->
        let cli1 = contains_return li1
        and cli2 = contains_return li2 in
        if (cli1 && not cli2 ) || (cli2 && not cli1) then
          collect_return (collect_return acc li2) li1
        else
          let acc = collect_sad_return acc li1 in
          let acc = collect_sad_return acc li2 in
          acc
    | _ -> tra acc i
  in
  match List.rev (nocomment instrs) with
  | hd::tl ->
      let acc = f (Instr.Writer.Traverse.fold f) acc hd in
      collect_return acc tl
  | [] -> acc

let collect_sad_return instrs = collect_sad_return IntSet.empty instrs

let contains_sad_return instrs = IntSet.empty <> collect_sad_return instrs

let collect_sad_returns ty instrs =
  let add acc l type_ =
    if contains_sad_return l then TypeSet.add type_ acc
    else acc
  in
  let rec f tra acc i = match Instr.unfix i with
    | Instr.AllocArray (_binding, type_, _len, Some (_b, l), _) ->
      add (tra acc i) l type_
    | _ -> tra acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f))
  (add TypeSet.empty instrs ty)
  instrs

(** the main class : the ocaml printer *)
class fsharpPrinter = object(self)
  inherit Printer.printer as super

  (** bindings by reference *)
  val mutable refbindings = BindingSet.empty
  (** sad return in the current function *)
  val mutable sad_returns = IntSet.empty
  val mutable printed_exn = TypeMap.empty
  (** true if we are processing an expression *)
  val mutable in_expr = false
  val mutable exn_count = 0

  method expr f e = print_expr refbindings (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

  method lang () = "fsharp"

  method untuple f li e =
    Format.fprintf f "@[<h>let (%a) = %a@]"
      (print_list self#binding sep_c) (List.map snd li)
      self#expr e

  method record f li =
    Format.fprintf f "{@\n  @[<v>%a@]@\n}"
      (self#def_fields (InternalName 0)) li

  (** show a type *)
  method ptype f (t : Ast.Type.t ) = OcamlFunPrinter.ptype f t

  (** read spaces from stdin *)
  method stdin_sep f = Format.fprintf f "@[stdin_sep()%a@]" self#separator ()

  (** show a binary operator *)
  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "mod"
      | Expr.Or -> "||"
      | Expr.And -> "&&"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "="
      | Expr.Diff -> "<>"
      )


  (** show the main *)
  method main f main =
    sad_returns <- collect_sad_return main;
    self#calc_refs main;
    self#calc_used_variables main;
    Format.fprintf f "@[<v 2>@[<h>let () =@\n@[<v 2>  %a@]@\n"
      self#instructions main

  (** show all the programm *)
  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    let op = need || Tags.is_taged "use_readline" in
    Format.fprintf f "%s%s%s%s%s%a%a"
(if op then "open System
" else "" )
(if need then "
let eof = ref false
let buffer = ref \"\"
let readChar_ () =
  if (!buffer) = \"\" then
    let tmp = Console.ReadLine()
    eof := tmp = null
    buffer := tmp + \"\\n\"
  (!buffer).[0]

let consommeChar () =
  ignore (readChar_ ())
  buffer := (!buffer).[1..]
" else "")

      (if need_readchar then "
let readChar () =
  let out_ = readChar_ ()
  consommeChar ()
  out_
" else "")

      (if need_stdinsep then "
let stdin_sep () =
  let cond () =
    if !eof then
      false
    else
      let c = readChar_()
      c = ' ' || c = '\\n' || c = '\\t' || c = '\\r'
  while cond () do
    consommeChar ()
" else "")
      (if need_readint then "
let readInt () =
  let sign =
    if readChar_ () = '-' then
      consommeChar ()
      -1
    else 1
  let rec loop i =
    let c = readChar_ ()
    if c <= '9' && c >= '0' then
      consommeChar ()
      loop (i * 10 + (int c) - (int '0'))
    else
      i * sign
  loop 0
" else "")


      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  (** print recursive prefix *)
  method rec_ f b =
    if b then Format.fprintf f "rec@ "

  (** show the prototype of a recursive function *)
  method print_rec_proto f triplet = self#print_proto_aux f true triplet

  (** show the prototype of a function*)
  method print_proto f triplet = self#print_proto_aux f false triplet


  (** util method to print a function prototype*)
  method print_proto_aux f rec_ ((funname:string), (t:Ast.Type.t), li) =
    let otype f ty =
      match Type.unfix ty with
      | Type.Void
      | Type.Integer -> ()
      | _ -> Format.fprintf f ": %a " self#ptype ty
    in
    match li with
    | [] -> Format.fprintf f "let@ %a%a@ () %a="
      self#rec_ rec_
      self#funname funname
          otype t
    | _ ->
      Format.fprintf f "let@ %a%a@ %a %a="
        self#rec_ rec_
        self#funname funname
        (print_list (fun f (name, ty) ->
          match Type.unfix ty with
          | Type.Integer -> self#binding f name
          | _ -> Format.fprintf f "(%a:%a)" self#binding name self#ptype ty
                    ) sep_space) li
          otype t

  (** show an if then else *)
  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]"
        self#expr e
        self#bloc ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse %a"
        self#expr e
        self#bloc ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]"
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  (** show an instruction *)
  method instructions f instrs =
    Format.fprintf f "%a%a"
      (print_list self#instr (sep "%a@\n%a")) instrs
      (fun f () -> Format.fprintf f (if self#need_unit instrs then "@\n()" else "")) ()

  (** returns true if the function need to returns unit *)
  method need_unit instrs =
    let instrs = nocomment instrs in
    if instrs = [] then true
    else match List.map Instr.unfix instrs |> List.rev with
    | (Instr.AllocArray _ | Instr.Declare _ | Instr.Untuple _) :: _ -> true
    | Instr.Read li :: _ ->
        begin match List.rev li with
        | Instr.DeclRead _ :: _ -> true
        | _ -> false
        end
    | (Instr.Affect ( Mutable.Fixed.F (_, Mutable.Var v), _)) :: _
      when not( BindingSet.mem v refbindings) -> true
    | _ -> false

  (** show a bloc of instructions *)
  method bloc f b =
    if List.forall
      (function
      | Instr.Fixed.F (_, (Instr.Comment _
                              | (Instr.If (_, _, _) )) (* sans begin end, on a un conflit sur le else *)) -> true
      | _ -> false
      )
      b
    then
      Format.fprintf f "@[<v 2>  %a@]" self#instructions b
    else
      match b with
      | [i] ->
        Format.fprintf f "%a@\n%s" self#instr i
          (if self#need_unit b then " ()" else "")
      | _ ->
        Format.fprintf f "@[<v 2>  %a@]" self#instructions b

  (** show a binding *)
  method binding f i =
    if BindingSet.mem i used_variables then
      Format.fprintf f "%a" super#binding i
    else
      Format.fprintf f "_%a" super#binding i

  method hasSelfAffect op = false

  (** show an affectation *)
  method affect f m expr =
    match Mutable.Fixed.unfix m with
      | Mutable.Var var ->
          if BindingSet.mem var refbindings
          then Format.fprintf f "@[<h>%a@ := %a@]"
              self#mutable_set m 
              self#expr expr
          else
              Format.fprintf f "@[<h>let %a@ = %a@]"
              self#mutable_set m 
              self#expr expr
      | _ ->
          Format.fprintf f "@[<h>%a@ <- %a@]"
            self#mutable_set m 
            self#expr expr

  (** show a declaration *)
  method declaration f var t e =
    if BindingSet.mem var refbindings then
      Format.fprintf f "@[<h>let %a@ =@ ref(@ %a )@]"
        self#binding var
        self#expr e
    else
      Format.fprintf f "@[<h>let %a@ =@ %a@]"
        self#binding var
        self#expr e

  (** read a value from stdin into a mutable *)
  method read f t m =
    Format.fprintf f "@[%a %s %a@]"
      self#mutable_set m
      (match m |> Mutable.Fixed.unfix with
      | Mutable.Var _ -> ":="
      | Mutable.Array _ -> "<-"
      | Mutable.Dot _ -> "<-"
      ) self#read_ty t

  method read_ty f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "readInt()"
    | Type.Char -> Format.fprintf f "readChar()"
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

  (** declare a variable and read his value from stdin *)
  method read_decl f t v =
    if BindingSet.mem v refbindings then
      Format.fprintf f "@[let %a = ref (%a)@]"
        self#binding v
        self#read_ty t
    else
      Format.fprintf f "@[let %a = %a@]"
        self#binding v
        self#read_ty t

  (** find references variables from a list of instructions *)
  method calc_refs instrs =
    let g acc i = Instr.Writer.Deep.fold
        (fun acc i ->
          match Instr.unfix i with
          | Instr.Read li ->
              List.fold_left (fun acc -> function
                | Instr.Separation -> acc
                | Instr.DeclRead _ -> acc
                | Instr.ReadExpr (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
                | Instr.ReadExpr _ -> acc) acc li
          | Instr.Affect (Mutable.Fixed.F (_, Mutable.Var varname), _) -> BindingSet.add varname acc
          | _ -> acc
        ) acc i
    in let f tra acc i = match Instr.unfix i with
    | Instr.Read li ->
        List.fold_left (fun acc -> function
          | Instr.ReadExpr (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
          | _ -> acc) acc li
    | Instr.Loop (_, _, _, li)
    | Instr.While (_, li) -> List.fold_left g acc li
    | Instr.AllocArray (_, _, _, Some (_, li), _) -> List.fold_left g acc li
    | Instr.If (_, li1, li2) ->
        let acc = List.fold_left g acc li1 in
        List.fold_left g acc li2
    | _ -> tra acc i
    in refbindings <- List.fold_left (f (Instr.Writer.Traverse.fold f)) BindingSet.empty instrs

  method m_variable f binding = if in_expr && BindingSet.mem binding refbindings
  then Format.fprintf f "(!%a)" self#binding binding
  else self#binding f binding

  method m_array f m indexes = Format.fprintf f "@[<h>%a.[%a]@]"
      self#mutable_get m
      (print_list self#expr (sep "%a].[%a")) indexes

  method print_exnName f (t : unit Type.Fixed.t) =
    try
      Format.fprintf f "%s" (TypeMap.find t printed_exn)
    with Not_found ->
      Format.fprintf f "NOT_FOUND_%a" self#ptype t

  method print_exns f exns =
    TypeMap.iter (fun ty str ->
      Format.fprintf f "exception %s of %a@\n"
        str
        self#ptype ty
    ) exns

  method used_affect () = true

  method print_fun f funname (t : unit Type.Fixed.t) li instrs =
    self#calc_refs instrs;
    self#calc_used_variables instrs;
    let is_rec = self#is_rec funname in
    let proto = if is_rec then self#print_rec_proto else self#print_proto in
    let sad_types = collect_sad_returns t instrs in
    let () = sad_returns <- collect_sad_return instrs in
    match t with
    | Type.Fixed.F (_, Type.Void) ->
      if sad_returns <> IntSet.empty then failwith("return in a void function : "^funname)
      else
        Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n"
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
    | _ ->
      if sad_returns = IntSet.empty then
        Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n"
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
      else
        let () =
          Warner.warn funname (fun t () -> Format.fprintf t "The returns will make a dirty ocaml code")
        in (* TODO faire un diff pour ne déclarer que les nouvelles *)
        let () = printed_exn <-
          TypeSet.fold (fun t (acc: string TypeMap.t) ->
            exn_count <- exn_count + 1;
            TypeMap.add t ("Found_"^(string_of_int exn_count)) acc
          ) sad_types
          TypeMap.empty
        in
        Format.fprintf f "%a@\n@[<h>%a@]@\n@[<v 2>  %atry@\n%a@\nwith %a (out) -> out@]@\n"
          self#print_exns printed_exn
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
          self#print_exnName t

  method ref_alias f li = match li with
  | [] -> ()
  | (name, _) :: tl ->
    let b = BindingSet.mem name refbindings in
    if b then
      Format.fprintf f "let %a = ref %a@\n%a"
        self#binding name
        self#binding name
        self#ref_alias tl
    else
      self#ref_alias f tl

  method combine_formats () = true

  method print f t expr =
    match Expr.unfix expr with
    | Expr.Lief (Expr.String s) -> Format.fprintf f "@[Printf.printf %s@]" ( self#noformat s)
    | _ ->
      Format.fprintf f "@[Printf.printf \"%a\" %a@]"
        self#format_type t
        (if self#nop (Expr.unfix expr) then
            self#expr
         else self#printp) expr

  method comment f str =
    Format.fprintf f "(*%s*)" str

  method return f e =
    if IntSet.mem (Expr.Fixed.annot e) sad_returns then
      Format.fprintf f "@[<h>raise (%a(%a))@]"
        self#print_exnName (Typer.get_type (self#getTyperEnv ())  e)
        self#expr e
    else
      Format.fprintf f "@[<h>%a@]" self#expr e

  method allocarray_lambda f binding type_ len binding2 lambda _ =
    let b = BindingSet.mem binding refbindings in
    match List.map (Instr.unfix) lambda with
    | [Instr.Return ( Expr.Fixed.F(_, Expr.Lief lief))] ->
        Format.fprintf f "@[<h>let %a@ =@ %aArray.create@ %a %a@]"
          self#binding binding
          (fun t () ->
            if b then
              Format.fprintf t "ref(@ "
          ) ()
          (fun f e ->
            if self#nop (Expr.unfix e) then self#expr f e
            else Format.fprintf f "(%a)" self#expr e
          ) len
          print_lief lief
    | _ ->
    let next_sad_return =sad_returns in
    sad_returns <- collect_sad_return lambda;
   Format.fprintf f "@[<h>let %a@ =@ %aArray.init@ %a@ (fun@ %a@ ->%a@\n@[<v 2>  %a%a@])%a@]"
(*  Format.fprintf f "@[<h>let %a@ =@ %a[| for %a in 1 .. %a ->@]@[<v>%a@\n@[<v 2>  %a%a@]|]@]%a@]" *)
      self#binding binding
      (fun t () ->
        if b then
          Format.fprintf t "ref(@ "
      ) ()
      (fun f len ->
        if self#nop (Expr.unfix len) then
          self#expr f len
        else Format.fprintf f "(%a)" self#expr len) len
self#binding binding2
      (fun f () ->
        if sad_returns <> IntSet.empty then Format.fprintf f "@ try@\n"
      ) ()
      self#instructions lambda
      (fun f () ->
        if sad_returns <> IntSet.empty then Format.fprintf f "@\nwith %a@ out -> out@\n"
          self#print_exnName type_
      ) ()
      (fun t () ->
        if b then
          Format.fprintf t ")"
      ) ();
    sad_returns <- next_sad_return;
    ()

  method allocarray f binding type_ len _ =
    let b = BindingSet.mem binding refbindings in
    Format.fprintf f "@[<h>let@ %a@ %a=@ Array.make@ %a@ (Obj.magic@ 0)%a@]"
      self#binding binding
      (fun t () ->
        if b then
          Format.fprintf t "ref(@ "
      ) ()
      self#expr len
      (fun t () ->
        if b then
          Format.fprintf t ")"
      ) ()

  method affectarray f binding indexes e2 =
    Format.fprintf f "@[<h>%a.(%a)@ <-@ %a@]"
      self#binding binding
      (print_list self#expr (sep "%a).(%a")) indexes
      self#expr e2


  method nop = function
  | Expr.Lief _ -> true
  | Expr.Access _ -> true
  | Expr.Call (_, _) -> false
  | Expr.Record _ -> true
  | _ -> false

  (* Todo virer les parentheses quand on peut*)
  method apply f var li =
    match StringMap.find_opt var macros with
    | Some _ -> super#apply f var li
    | None ->
      match li with
      | [] ->
        Format.fprintf f "@[<h>(%a ())@]"
          self#funname var
      | _ ->
        Format.fprintf
          f
          "@[<h>%a %a@]"
          self#funname var
          (print_list
             (fun t e ->
               if self#nop (Expr.unfix e) then self#expr f e
               else Format.fprintf f "(%a)" self#expr e
             )
             sep_space
          ) li

  method call f var li =
    self#apply f var li

  method whileloop f expr li =
    Format.fprintf f "@[<v 2>@[<h>while %a do@]@\n%a@]@\n"
      self#expr expr
      self#instructions li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v 2>@[<h>for@ %a@ =@ %a@ to@ %a@ do@]@\n%a@]"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>%a=%a;@]"
          self#field fieldname
          self#expr expr
      )
      sep_nl f li

  method allocrecord f name t el =
    let b = BindingSet.mem name refbindings in
    Format.fprintf f "let %a = %a{@\n@[<v 2>  %a@]@\n}%a"
      self#binding name
      (fun t () ->
        if b then
          Format.fprintf t "ref(@ "
      ) ()
      (self#def_fields name) el
      (fun t () ->
        if b then
          Format.fprintf t ")"
      ) ()

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "type %s = {@\n@[<v 2>  %a@]@\n};;@\n"
          name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "@[<h>mutable %s : %a;@]"
                 name
                 self#ptype type_
             ) sep_nl
          ) li
    | Type.Enum li ->
      Format.fprintf f "type %s = @\n@[<v2>    %a@]@\n"
        name (print_list (fun f s -> Format.fprintf f "%s" s) (sep "%a@\n| %a")) li
    | _ ->
      Format.fprintf f "type %a = %a;;"
        super#typename name
        super#ptype t

  method printf f () = Format.fprintf f "Printf.printf"
  method multi_print f li =
    let limit = 50 in
    if List.length li > limit then
      let lili = List.pack limit li in
      print_list self#multi_print sep_nl f lili
    else
      let format, exprs = self#extract_multi_print li in
      if exprs = [] then
        Format.fprintf f "@[<h>%a \"%s\"@]" self#printf () format
      else
        Format.fprintf f "@[<h>%a \"%s\" %a@]" self#printf ()  format
          (print_list
             (fun f (t, expr) ->
               (if self#nop (Expr.unfix expr) then
                 self#expr
               else self#printp) f expr) sep_space ) exprs

end