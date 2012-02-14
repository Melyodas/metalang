open Stdlib
open Ast

let myprog =
  Expr.add

    ( Expr.add
	(
	   Expr.add

    ( Expr.add (Expr.integer 1)
	(Expr.sub
	   (Expr.add (Expr.integer 2) (Expr.integer 4))
	   (Expr.add (Expr.integer 3) (Expr.integer 5))
	)) 
    ( Expr.add (Expr.integer 2)
	(
  Expr.add

    ( Expr.add (Expr.integer 1)
	(Expr.sub
	   (Expr.add (Expr.integer 2) (Expr.integer 4))
	   (Expr.add (Expr.integer 3) (Expr.integer 5))
	)) 
    ( Expr.add (Expr.integer 2) (Expr.integer 3))
	))
	)
	(Expr.sub
	   (Expr.add (Expr.integer 2) (Expr.integer 4))
	   (Expr.add (Expr.integer 3) (Expr.integer 5))
	)) 
    ( Expr.add (Expr.integer 2) (Expr.integer 3))
|> Expr.mul (Expr.integer 2)
;;


let () = Format.fprintf Format.std_formatter "%a\n= %a\n"
    Printer.expr myprog
    Expr.Eval.print
    (Expr.Eval.eval myprog);;

let myprog2 =
  Prog.declarefun
    "calc"
    ["n"; "a"; "b"]
    [
     Instr.declare "i";
     Instr.declare "d";
     Instr.declare "tab";
     Instr.alloc_array "tab" Type.integer (Expr.binding "n");     
     Instr.loop "i" (Expr.integer 2) (Expr.binding "n") (Expr.integer 1)
       [
	Instr.affect_array "tab" (Expr.binding "i") (Expr.binding "a");
	Instr.affect "d" (Expr.binding "b");
	Instr.affect "b" (Expr.add (Expr.binding "b") (Expr.binding "a"));
	Instr.affect "a" (Expr.binding "d");
      ];
     Instr.return (Expr.binding "b");
   ]


let () = Format.fprintf Format.std_formatter "%a\n"
    Printer.prog myprog2;;
