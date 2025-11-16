{
module Lexer where

import Tokens

}

%wrapper "basic"

$digit = [0-9]
$char = [A-Za-z0-9!@#\$\%\^&\*\(\)$white\>\<\.\,\-\+]
@int = $digit+
@double = '-'?$digit+\.$digit* | \.$digit+
@id     = [A-Za-z]([A-Za-z] | ['_'] | $digit)*
@literal = \"([^\"\\]|\\.)*\" -- \'$char*\' | \"$char*\"

tokens :-

<0> {
	$white+ ;
	@int {\s -> CINT (read s)}
	@double {\s -> CDOUBLE (parseDolStr s)}
	"int" {\s -> TINT}
	"string" {\s -> TSTRING}
	"double" {\s -> TDOUBLE}
	"void" {\s -> TVOID}
	@literal {\s -> LITERAL (read s)}
	"if" {\s -> TIF}  
	"else" {\s -> TELSE}
	"while" {\s -> TWHILE}
	"for"   {\s -> TFOR}
	"read" {\s -> TREAD}
	"print" {\s -> TPRINT}
	"return" {\s -> TRETURN}
	";" {\s -> SEMICOLON}
	@id {\s -> ID s}
	"+" {\s -> ADD}  
	"-" {\s -> SUB}  
	"*" {\s -> MUL}  
	"/" {\s -> DIV}  
	"(" {\s -> LPAR}  
	")" {\s -> RPAR}
	">=" {\s -> MAJEQ}
	"<=" {\s -> MINEQ}
	"<" {\s -> MINOR}
	">" {\s -> MAJOR}
	"==" {\s -> EQUAL}
	"=" {\s -> ATRIB}
	"!=" {\s -> NEQUAL}  
	"[" {\s -> LBRACK}  
	"]" {\s -> RBRACK}
	"{" {\s -> LCBRAK}
	"}" {\s -> RCBRAK}
	"!" {\s -> NOT} 
	"&&" {\s -> AND} 
	"||" {\s -> OR} 
	"," {\s -> COMMA}
}
{

testLex = do s <- getLine
             print (alexScanTokens s)

parseDolStr str = case str of
  ('-':n) -> - (parseDolStr n)
  ('.':n) -> read ('0':str)
  n       -> read $
               if last n == '.'
               then n ++ "0"
               else n
}
