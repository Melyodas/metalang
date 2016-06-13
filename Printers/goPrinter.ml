(*
 * Copyright (c) 2012, Prologin
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


(** GO Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Helper
open Stdlib

let print_lief prio f l =
    let open Format in
    let open Expr in match l with
    | Char c -> clike_char f c
    | String s -> fprintf f "%S" s
    | Integer i ->
        if i < 0 then parens prio (-1) f "%i" i
        else Format.fprintf f "%i" i
    | Bool true -> fprintf f "true"
    | Bool false -> fprintf f "false"
    | Enum s -> fprintf f "%s" s

let print_mut conf prio f m = Mutable.Fixed.Deep.fold (print_mut0 "%a%a" "[%a]" "(*%a).%s" conf) m f prio
      
let config macros = {
  prio_binop;
  prio_unop;
  print_varname;
  print_lief;
  print_op;
  print_unop;
  print_mut;
  macros
}
          
let print_expr config e f p = Expr.Fixed.Deep.fold (print_expr0 config) e f p

let ptype tyenv f ty =
  let open Type in
  let open Format in
  let ptype ty f () = match ty with
  | Integer -> fprintf f "int"
  | String -> fprintf f "string"
  | Array a -> fprintf f "[]%a" a ()
  | Void ->  fprintf f ""
  | Bool -> fprintf f "bool"
  | Char -> fprintf f "byte"
  | Named n -> begin match Typer.expand tyenv (Type.named n)
        default_location |> Type.unfix with
        | Type.Struct _ -> Format.fprintf f "* %s" n
        | Type.Enum _ -> Format.fprintf f "%s" n
        | _ -> assert false
    end
  | Enum _ | Struct _ | Tuple _ | Auto | Lexems -> assert false
  in Fixed.Deep.fold ptype ty f ()

let ptypename f t = match Type.unfix t with
| Type.Named n -> Format.fprintf f "%s" n
| _ -> assert false

let print_instr tyenv used_variables c i =
  let ptype = ptype tyenv in
  let open Ast.Instr in
  let open Format in
  let block f li = fprintf f " {@\n%a@]@\n}" (print_list (fun f i -> i.p f noseppt) sep_nl) li in
  let p f pend = match i with
  | Declare (var,  Type.Fixed.F(_, Type.Integer), e, _) ->
      if BindingSet.mem var used_variables then
        fprintf f "%a := %a%a" c.print_varname var e nop pend ()
      else
        fprintf f "%a := %a%a@\n@[<h>_ = %a@]%a"
          c.print_varname var e nop pend ()
          c.print_varname var pend ()
  | Declare (var, ty, e, _) -> if BindingSet.mem var used_variables then
      fprintf f "var %a %a = %a%a" c.print_varname var ptype ty e nop pend ()
  else
      fprintf f "var %a %a = %a%a@\n_  = %a%a" c.print_varname var ptype ty e nop pend ()
        c.print_varname var pend ()
    | SelfAffect (mut, op, e) -> fprintf f "%a %a= %a%a" (c.print_mut c nop) mut c.print_op op e nop pend ()
    | Affect (mut, e) -> fprintf f "%a = %a%a" (c.print_mut c nop) mut e nop pend ()
    | Loop (var, e1, e2, li) -> assert false
    | ClikeLoop (init, cond, incr, li) ->
        fprintf f "@[<v 4>for %a; %a; %a%a"
          plifor init
          cond nop
          plifor incr
          block li
    | While (e, li) -> fprintf f "@[<v 4>for @[<h>%a@]%a" e nop block li
    | Comment s -> fprintf f "/*%s*/" s
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> fprintf f "return %a%a" e nop pend ()
    | AllocArray (name, t, e, None, opt) -> fprintf f
          "@[<h>var %a@ []%a@ = make([]%a, %a)%a@]"
          c.print_varname name
          ptype t ptype t
          e nop
          pend ()
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) -> assert false
    | AllocRecord (name, ty, list, opt) ->
        fprintf f "@[<v 4>var %a %a = new (%a)@\n%a%a@]" c.print_varname name
          ptype ty
          ptypename ty
          (print_list (fun f (field, x) -> fprintf f "(*%a).%s=%a"
              c.print_varname name
              field x nop) sep_nl) list
          pend ()
    | If (e, listif, []) ->
        fprintf f "@[<v 4>if %a%a" e nop block listif
    | If (e, listif, listelse) ->
        fprintf f "@[<v 4>if %a%a@[<v 3>else%a" e nop block listif block listelse
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
      | Some ( (t, params, code) ) -> pmacros f "%s%a" t params code li nop pend ()
      | None -> fprintf f "%s(%a)%a" func (print_list (fun f x -> x f nop) sep_c) li pend ()
    end
    | Print li->
        let format, exprs = extract_multi_print clike_noformat format_type li in
        begin match exprs with
        | [] -> fprintf f "fmt.Printf(\"%s\")%a" format pend ()
        | _ -> fprintf f "fmt.Printf(\"%s\", %a)%a" format
              (print_list (fun f (t, e) -> e f nop) sep_c) exprs pend ()
        end
    | Read li ->
        let declare_variables f = function
          | [] -> ()
          | li -> fprintf f "%a@\n"
                (print_list
                   (fun f (ty, v) ->
                     fprintf f "var %a %a" c.print_varname v ptype ty
                   ) (sep_nl)) li
        in
        let _, _, declared = split_multi_read li " " format_type in
        let li = List.map (function
          | Separation -> fun f -> fprintf f "@[skip()@]"
          | i -> fun f -> let li = [i] in
            let format, variables, _ = split_multi_read li " " format_type in
            fprintf f "@[fmt.Fscanf(reader, \"%s\", %a)@]"
              format
              (print_list (fun f v -> Format.fprintf f "&%a" (c.print_mut c nop) v) (sep "%a, %a")) variables ) li in
        fprintf f "%a%a"
          declare_variables declared
          (print_list (fun f g -> g f) sep_nl) li
    | Untuple (li, expr, opt) -> fprintf f "var (%a) = %a%a" (print_list c.print_varname sep_c) (List.map snd li) expr nop pend ()
    | Unquote e -> assert false in
  let is_multi_instr = match i with
  | Read (hd::tl) -> true
  | Declare (var, _, _, _) -> not (BindingSet.mem var used_variables)
  | _ -> false in
  {
   is_multi_instr = is_multi_instr;
   is_if=is_if i;
   is_if_noelse=is_if_noelse i;
   is_comment=is_comment i;
   p=p;
   default = noseppt;
   print_lief = c.print_lief;
 }

let print_instr tyenv used_variables macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config macros in
  let i = (fold (print_instr tyenv used_variables c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default

class goPrinter = object(self)
  inherit CPrinter.cPrinter as super

  method instr f t =
   let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros
   in (print_instr (self#getTyperEnv ()) used_variables macros t) f
     
  method lang () = "go"

  method print_fun f funname t li instrs =
    self#calc_used_variables instrs;
    Format.fprintf f "@[<h>%a@]{@\n@[<v 2>  %a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  val mutable reader = false
  method prog f prog =
    let need li = List.exists (Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
      | Instr.Print _ -> true
      | _ -> acc) false) li in
    let need_prog_item = function
      | Prog.DeclarFun (var, t, li, instrs, _) ->
        need instrs
      | _ -> false
    in
    let need_print = (match prog.Prog.main with
      | Some s -> need s
      | None -> false) || List.exists need_prog_item prog.Prog.funs
    in
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    reader <- need;
    Format.fprintf f
      "package main@\n%a%a%a%a%a%a"
      (fun f () -> if need || need_print then Format.fprintf f "import \"fmt\"@\n") ()
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "import \"math\"@\n"
      ) ()
      (fun f () -> if need then Format.fprintf f "import \"os\"@\nimport \"bufio\"@\nvar reader *bufio.Reader@\n") ()
(fun f () -> if need_stdinsep then Format.fprintf f "
func skip() {
  var c byte
  fmt.Fscanf(reader, \"%%c\", &c)
  if c == '\\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}
") ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method main f main =
    self#calc_used_variables main;
    (if reader then
        Format.fprintf f "func main() {@\n  reader = bufio.NewReader(os.Stdin)@\n  @[<v>%a@]@\n}@\n"
     else
        Format.fprintf f "func main() {@\n  @[<v>%a@]@\n}@\n")
      self#instructions main

  method print_proto f (funname, t, li) =
    Format.fprintf f "func %a(%a) %a"
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a@ %a"
             self#binding binding
             self#prototype type_
         ) sep_c
      ) li
      self#ptype t

  method ptype f t = match Type.unfix t with
  | Type.Array a -> Format.fprintf f "[]%a" self#ptype a
  | Type.String -> Format.fprintf f "string"
  | Type.Char -> Format.fprintf f "byte"
  | Type.Bool -> Format.fprintf f "bool"
  | Type.Void -> Format.fprintf f ""
  | Type.Named n ->
    begin match Typer.expand (super#getTyperEnv ()) t
        default_location |> Type.unfix with
        | Type.Struct _ -> Format.fprintf f "* %s" n
        | Type.Enum _ -> Format.fprintf f "%s" n
        | _ -> assert false
    end
  | _ -> super#ptype f t

  method decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "@\ntype %a struct {@\n@[<v 2>  %a@]@\n}@\n"
        self#typename name
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%a %a;" self#field name self#ptype type_
           ) sep_nl
        ) li
    | Type.Enum li ->
      Format.fprintf f "type %a int@\nconst (@\n@[<v2>  %a@]@\n);"
        self#typename name
        (print_list
           (fun t fname ->
             Format.fprintf t "%s %s = iota" fname name
           ) sep_nl
        ) li
    | _ -> Format.fprintf f "type %a %a;" self#typename name self#ptype t

end

