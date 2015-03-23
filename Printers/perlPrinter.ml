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

(** Perl Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Helper
open Stdlib
open CPrinter
open Printer

class perlPrinter = object(self)
  inherit cPrinter as baseprinter

  method lang () = "pl"

  method is_stdin i =false

  method combine_formats () = false

  method binding f i = Format.fprintf f "$%a" baseprinter#binding i

  method bool f = function
  | true -> Format.fprintf f "1"
  | false -> Format.fprintf f "()"

  method main f main = self#instructions f main

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] -> (*begin match ifcase with
      | [item] ->
        Format.fprintf f "%a if (%a);" 
          self#instr item
          self#expr e
      | _ ->*)
        Format.fprintf f "@[<h>if@ (%a)@] {@\n  @[<v>%a@]@\n}"
          self#expr e
          self#instructions ifcase
(*end*)
    | [Instr.Fixed.F (_, Instr.If (e2, if2, els2))] ->

      Format.fprintf f "@[<h>if@ (%a)@] {@\n  @[<v>%a@]@\n}els%a"
        self#expr e
        self#instructions ifcase
        (fun f () -> self#if_ f e2 if2 els2) ()
    | _ ->
      Format.fprintf f "@[<h>if@ (%a)@] {@\n  @[<v>%a@]@\n}else{@\n  @[<v>%a@]@\n}"
        self#expr e
        self#instructions ifcase
        self#instructions elsecase

  method expr_inprint f expr = match Expr.unfix expr with
  | Expr.BinOp _ -> Format.fprintf f "(%a)" self#expr expr
  | _ -> self#expr f expr

  method print f t expr =
    Format.fprintf f "print %a;" self#expr_inprint expr

  method multi_print f format exprs =
    Format.fprintf f "@[<h>print(%a);@]"
      (print_list self#expr sep_c ) (List.map snd exprs)

  method print_proto f (funname, t, li) =
    if li = [] then Format.fprintf f "sub %a{" self#funname funname
    else
    Format.fprintf f "sub %a{@\n@[<h>my(%a) = @@_;@]"
      self#funname funname
      (print_list self#binding sep_c) (List.map fst li)


  method print_fun f funname t li instrs =
    Format.fprintf f "@[<v 2>%a@\n%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method decl_type f name t = ()

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "#!/usr/bin/perl@\n%a%a%a%a%a%a@\n%a%a@\n@\n"
(fun f () ->
  if Tags.is_taged "perl_use_list_min" then Format.fprintf f "use List::Util qw(min max);@\n"
) ()
      (fun f () ->
	if need then Format.fprintf f "sub nextchar{ sysread STDIN, $currentchar, 1; }@\n") ()
      (fun f () ->
	if need_readchar then Format.fprintf f
	  "sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar;
  return $o;
}@\n") ()
      (fun f () ->
	if need_readint then Format.fprintf f
	  "sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar;
  }
  while ($currentchar =~ /\\d/){
    $o = $o * 10 + $currentchar;
    nextchar;
  }
  return $o * $sign;
}@\n") ()
      (fun f () ->
	if need_stdinsep then Format.fprintf f
	  "sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq \"\\r\" || $currentchar eq \"\\n\"){ nextchar() ; }
}@\n") ()
      (fun f () -> if Tags.is_taged "__internal__mod" then Format.fprintf f
	  "sub remainder {
    my ($a, $b) = @@_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}
"
      ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method declaration f var t e =
    Format.fprintf f "@[<h>my %a@ =@ %a;@]"
      self#binding var
      self#expr e

  method comment f s =
    let lic = String.split s '\n' in
      print_list (fun f s -> Format.fprintf f "#%s@\n" s) nosep f lic

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>my %a = [];@]"
     self#binding binding

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v 2>@[<h>foreach my %a (%a .. %a) {@]@\n%a@]@\n}"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li

  method read_decl f t v = match Type.unfix t with
  | Type.Char -> Format.fprintf f "my %a = readchar();" self#binding v
  | Type.Integer ->  Format.fprintf f "my %a = readint();" self#binding v
  | _ -> assert false

  method read f t mutable_ = match Type.unfix t with
  | Type.Char -> Format.fprintf f "%a = readchar();" self#mutable_ mutable_
  | Type.Integer ->  Format.fprintf f "%a = readint();" self#mutable_ mutable_
  | _ -> assert false

  method stdin_sep f = Format.fprintf f "@[readspaces();@]"

  method allocrecord f name t el =
    Format.fprintf f "my %a = {@[<v>%a@]};"
      self#binding name
      ( print_list (fun f (fieldname, expr) ->
	      Format.fprintf f "%S=>@[<h>%a@]" fieldname self#expr expr)
	        (sep "%a,@\n%a")) el

  method record f li = Format.fprintf f "{%a}" (self#def_fields (InternalName 0)) li
  method field f field = Format.fprintf f "%S" field
  method tuple f li = Format.fprintf f "[%a]" (print_list self#expr sep_c) li

  method def_fields name f li =
    Format.fprintf f "@[<h>%a@]"
      (print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f "%a => %a"
             self#field fieldname
             self#expr expr
         )
         (sep "%a,@\n%a"))
      li

  method untuple f li e =
    Format.fprintf f "my (%a) = @@{ %a };"
      (print_list self#binding sep_c) (List.map snd li) self#expr e

  method selfAssoc f m e2 op = match op with
  | Expr.Mod ->
    Format.fprintf f "%a = remainder(%a, %a);"
      self#mutable_ m
      self#mutable_ m
      self#expr e2
  | Expr.Div ->
    Format.fprintf f "%a = int((%a) / (%a));"
      self#mutable_ m
      self#mutable_ m
      self#expr e2
  | _ ->
    Format.fprintf f "%a = %a %a %a;"
      self#mutable_ m
      self#mutable_ m
      self#print_op op
      self#expr e2

  method bloc f li =
    Format.fprintf f "@[<v 2>{@\n%a@]@\n}" self#instructions li


  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a->{%S}" self#mutable_ m field
    | Mutable.Var binding -> self#binding f binding
    | Mutable.Array (m, indexes) ->
      Format.fprintf f "%a->[%a]"
        self#mutable_ m
        (print_list self#expr (sep "%a][%a")) indexes

  method binop f op a b = match op with
  | Expr.Mod -> Format.fprintf f "remainder(%a, %a)" self#expr a self#expr b
  | Expr.Div -> Format.fprintf f "int((%a) / (%a))" self#expr a self#expr b
  | _ -> baseprinter#binop f op a b

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "%"
      | Expr.Or -> "||"
      | Expr.And -> "&&"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "eq"
      | Expr.Diff -> "ne"
      )

end
