{
  open Parser
}

let spacing = [' ' '\t' '\n']+
let ident = ['a'-'z'] ['0'-'9' 'a'-'z' 'A'-'Z']*
let commentignore = '#' [^'\n']*

rule token = parse
    commentignore { token lexbuf }
| spacing { token lexbuf }
(*    spacing { SPACING } *)

| "print" { PRINT }
| "read" { READ }
| "prog" { PROG }
| "if" { IF }
| "else" { ELSE }
| "var" { DECLAREVAR }
| "function" { FUNCTION }
| "return" { RETURN }
| "for" { FOR }
| "to" { TO }
| "step" { STEP }
| "dim" { DIM }
| "," { COMMA }
| ";" { DOTCOMMA }
| ":=" { AFFECT }
| "bool" { TYPE( Type.bool ) }
| "integer" { TYPE( Type.integer ) }
| "void" { TYPE( Type.void ) }
| "float" { TYPE( Type.float ) }

| "string" { TYPE( Type.string ) }
| "array" { ARRAY }

  | ['0'-'9']+ '.' ['0'-'9']* as t { FLOAT( float_of_string t) }
  | ['0'-'9']+ as t { INT( int_of_string t) }
  | "true" { BOOL(true) }
  | "false" { BOOL(false) }
  | "+" { O_ADD }
  | "-" { O_NEG }
  | "*" { O_MUL }
  | "/" { O_DIV }
  | "%" { O_MOD }
  | "mod" { O_MOD }

  | "||" { O_OR }
  | "&&" { O_AND }

  | "or" { O_OR }
  | "and" { O_AND }
  | "not" { O_NOT }

  | "|" { O_BOR }
  | "lor" { O_BOR }
  | "&" { O_BAND }
  | "land" { O_BAND }
  | "~" { O_BNOT }
  | "lnot" { O_BNOT }
  | "<<" { O_BLSHIFT }
  | "lsl" { O_BLSHIFT }
  | ">>" { O_BRSHIFT }
  | "lsr" { O_BRSHIFT }

  | "==" { O_EQ }
  | "!=" { O_DIFF }

  | "!" { O_NOT }
  | "<>" { O_DIFF }

  | ">" { O_HIGHER }
  | ">=" { O_HIGHEREQ }
  | "<" { O_LOWER }
  | "<=" { O_LOWEREQ }

  | "[" { LBRACE }
  | "]" { RBRACE }
  | "{" { LHOOK }
  | "}" { RHOOK }
  | "(" { LPARENT }
  | ")" { RPARENT }
  | "%" (ident as b) { VARNAME(b) }
  | (ident as b) { NAME(b) }


  | eof{ EOF }
