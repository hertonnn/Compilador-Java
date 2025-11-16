{
module Parser where

import Tokens
import AST
import qualified Lexer as L

}


%name calc Programa
%tokentype { Tokens }
%error { parseError }
%token

  CInt    { CINT $$ }
  CDouble { CDOUBLE $$ }
  literal { LITERAL $$ }
  '+'     { ADD }
  '-'     { SUB }
  '*'     { MUL }
  '/'     { DIV }

  '('     { LPAR }
  ')'     { RPAR }
  '['     { LBRACK }
  ']'     { RBRACK }
  '{'     { LCBRAK }
  '}'     { RCBRAK }
  ','     { COMMA }
  ';'     { SEMICOLON }

  '>='    { MAJEQ }
  '<='    { MINEQ }
  '<'     { MINOR }
  '>'     { MAJOR }
  '=='    { EQUAL }
  '!='    { NEQUAL }

  '&&'    { AND }
  '||'    { OR }
  '!'     { NOT }

  id      { ID $$ }

  int     { TINT }
  string  { TSTRING }
  double  { TDOUBLE }
  void    { TVOID }

  return  { TRETURN }
  read    { TREAD }
  '='     { ATRIB }
  print   { TPRINT }

  while   { TWHILE }
  for     { TFOR }
  if      { TIF }
  else    { TELSE }


%left '||' '&&'
%right '!'
%nonassoc '==' '!=' '>' '<' '>=' '<='
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

ExprL
  : ExprL '&&' ExprL    { And $1 $3 }
  | ExprL '||' ExprL    { Or $1 $3 }
  | '!' ExprL           { Not $2 }
  | '(' ExprL ')'       { $2}
  | ExprR               { Rel $1 }

ExprR
  : Expr '==' Expr    { Req $1 $3 }
  | Expr '!=' Expr    { Rdif $1 $3}
  | Expr '>'  Expr    { Rgt $1 $3 }
  | Expr '<'  Expr    { Rlt $1 $3 }
  | Expr '>=' Expr    { Rge $1 $3 }
  | Expr '<=' Expr    { Rle $1 $3 }

Expr
    : Expr '+' Expr         { Add $1 $3 }
    | Expr '-' Expr         { Sub $1 $3 }
    | Expr '*' Expr         { Mul $1 $3 }
    | Expr '/' Expr         { Div $1 $3 }
    | '-' Expr %prec UMINUS { Neg $2 }
    | '(' Expr ')'          { $2 }
    | CInt                  { Const (CInt $1) }
    | CDouble               { Const (CDouble $1) }
    | ChamadaF         { $1 }      
    | id                    { IdVar $1 }

Programa  : ListaFuncoes BlocoPrincipal {case $2 of
                                         BlocoP v c -> Prog (map (funcaoDeFundef) $1) (map (defDeFundef) $1) v c}
          | BlocoPrincipal {case $1 of
                           BlocoP v c -> Prog [] [] v c}

ListaFuncoes  : ListaFuncoes Funcao   {$1 ++ [$2]} 
              | Funcao                {[$1]}

Funcao  : TipoRetorno id '(' DeclParametros ')' BlocoPrincipal    {FunDef ($2 :->: ($4, $1)) $6}
        | TipoRetorno id '(' ')' BlocoPrincipal                   {FunDef ($2 :->: ([], $1)) $5}

TipoRetorno : Tipo  { $1 }
            | void  { TVoid } 

DeclParametros  : DeclParametros ',' Parametro  {$1 ++ [$3]}
                | Parametro                     {[$1]}

Parametro : Tipo id {$2:#:($1,0)}

BlocoPrincipal  : '{' Declaracoes ListaCmd '}'  {BlocoP $2 $3} 
                | '{' ListaCmd '}'              {BlocoP [] $2}

Declaracoes : Declaracoes Declaracao  {$1 ++ $2}
            | Declaracao              {$1}

Declaracao : Tipo ListaId ';'   {map (\s -> s:#:($1,0)) $2}

Tipo  : int     { TInt }  
      | string  { TString }
      | double  { TDouble }

ListaId : ListaId ',' id  {$1 ++ [$3]}
        | id              {[$1]}

Bloco : '{' ListaCmd '}' {$2}

ListaCmd  : ListaCmd Comando  {$1 ++ [$2]}
          | Comando           {[$1]}

Comando : CmdSe {$1}
        | CmdEnquanto {$1}
        | CmdDurante  {$1}
        | CmdAtrib    {$1}
        | CmdEscrita  {$1}
        | CmdLeitura  {$1}
        | ChamadaProc {$1}
        | Retorno     {$1}

Retorno : return Expr ';'     {Ret (Just $2)}
        | return literal ';'  {Ret (Just (Lit $2))}
        | return ';'          {Ret (Nothing)}

CmdSe : if '(' ExprL ')' Bloco            {If $3 $5 []}
      | if '(' ExprL ')' Bloco else Bloco {If $3 $5 $7}

CmdEnquanto : while '(' ExprL ')' Bloco { While $3 $5 }

CmdDurante : for '(' CmdAtribFor ';' ExprL ';' CmdAtribFor ')' Bloco { For $3 $5 $7 $9 }

CmdAtrib  : id '=' Expr ';'     {Atrib $1 $3}
          | id '=' literal ';'  {Atrib $1 (Lit $3)}

CmdAtribFor  : id '=' Expr  {Atrib $1 $3}
          | id '=' literal      {Atrib $1 (Lit $3)}

CmdEscrita  : print '(' Expr ')' ';'    {Imp $3} 
            | print '(' literal ')' ';' {Imp (Lit $3)}

CmdLeitura : read '(' id ')' ';' {Leitura $3}

ChamadaProc : ChamadaF ';' {
                                  case $1 of
                                    Chamada id args -> Proc id args
                                    _               -> error("Call incorrect")
                                }

ChamadaF : id '(' ListaParametros ')'  { Chamada $1 $3}
              | id '(' ')'                  { Chamada $1 []}

ListaParametros : ListaParametros ',' Expr    {$1 ++ [$3]}
                | ListaParametros ',' literal {$1 ++ [Lit $3]}
                | Expr                        {[$1]}
                | literal                     {[Lit $1]}
{
parseError :: [Tokens] -> a
parseError s = error ("Parse error:" ++ show s)

funcaoDeFundef :: FuncD -> Funcao
funcaoDeFundef (FunDef f c) = f

defDeFundef :: FuncD -> (Id, [Var], Bloco)
defDeFundef (FunDef (i:->:(v,t)) (BlocoP d c)) = (i,v++d,c)

main = do putStr "Digite o nome do arquivo que deseja ler: "
          arquivo <- getLine
          s <- readFile arquivo
          print (calc (L.alexScanTokens s))
}



