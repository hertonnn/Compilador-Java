
# Compilador Java

![img](https://optim.tildacdn.net/tild6638-3234-4266-b630-646530643738/-/resize/760x/-/format/webp/compiler.jpg.webp)

Antes de mais nada, construir um compilador é um dos projetos mais clássicos e gratificantes da Ciência da Computação. O uso de Haskell com as ferramentas Alex e Happy é uma escolha fantástica, pois a linguagem é extremamente adequada para a manipulação de estruturas de dados em árvore, como a sua Árvore Sintática Abstrata (AST).


O processo de compilação é classicamente dividido em fases. Para a nossa primeira etapa do trabalho, iremos focar nas duas primeiras: Análise Léxica e Análise Sintática.

## Passo 0: Entendendo a Arquitetura do Compilador


Antes de escrever qualquer código, é crucial entender o fluxo de dados:
1. **Código Fonte** (arquivo .txt): if (a > 5) { print(a); }

2. **Analisador Léxico (Alex):** Transforma o texto em uma sequência de "tokens". Pense neles como as "palavras" da linguagem.
    
        [IF, LPAREN, ID("a"), GT, INT(5), RPAREN, LBRACE, PRINT, LPAREN, ID("a"), RPAREN, SEMICOLON, RBRACE]

3. **Analisador Sintático (Happy):** Recebe os tokens e verifica se eles formam "frases" válidas de acordo com a gramática. Se a sintaxe estiver correta, ele monta a Árvore Sintática Abstrata (AST).
    
        If (Rel (Rgt (IdVar "a") (Const (CInt 5)))) [Imp (IdVar "a")] []

4. **Analisador Semântico (Nossa Próxima Etapa):** Percorre a AST para verificar o significado e as regras de tipo (ex: você não pode somar uma string com um inteiro).

5. **Geração de Código (Etapa Final):** Percorre a AST (já validada) e gera o código final, que no nosso caso são os mnemônicos do Jasmin.


## Passo 1: Análise Léxica com Alex (O "O Quê" da Linguagem)

O analisador léxico, ou scanner, agrupa caracteres em tokens. O Alex é uma ferramenta que gera esse analisador para você a partir de um arquivo de especificações (.x).

Irei criar um passo a passo aqui, para mais informações a acesse a [Documentação Alex](https://haskell-alex.readthedocs.io/en/latest/index.html)

### 1.1. Defina seus Tokens em Haskell

Primeiro, você precisa de um tipo de dado em Haskell para representar todos os tokens possíveis da sua linguagem. Crie um arquivo, por exemplo, Tokens.hs.

~~~haskell
-- Tokens.hs
module Tokens where

data Token
  = TIf
  | TElse
  | TWhile
  | TPrint
  | TRead
  | TReturn
  | TInt
  | TDouble
  | TString
  | TVoid
  | TId String      -- Identificador com seu nome
  | TConsInt Int    -- Constante inteira com seu valor
  | TConsDouble Double -- Constante double com seu valor
  | TLiteral String -- Literal string com seu conteúdo
  -- Operadores e Pontuação
  | TPlus
  | TMinus
  | TMult
  | TDiv
  | TAssign
  | TEq | TNeq | TLt | TLe | TGt | TGe -- Relacionais ==, /=, <, <=, >, >=
  | TAnd | TOr | TNot                 -- Lógicos &&, ||, !
  | TLparen | TRparen                  -- ( )
  | TLbrace | TRbrace                  -- { }
  | TComma | TSemicolon             -- , ;
  deriving (Show, Eq)
~~~

Obs: **deriving (Show, Eq)** é uma instrução para o compilador Haskell que diz: "Para este tipo de dado que acabei de criar, por favor, gere automaticamente para mim o código padrão para duas funcionalidades: mostrar o valor como texto (Show) e comparar dois valores por igualdade (Eq)".

### 1.2. Crie o Arquivo do Alex (Lexer.x)

Este arquivo tem 3 seções, separadas por { e }.

- **Seção 1: Código Haskell:** Importações e definições auxiliares.
- **Seção 2: Definições de Expressões Regulares:** Apelidos para facilitar a escrita.
- **Seção 3: Regras:** A parte principal. Para cada expressão regular, você define uma ação em Haskell para retornar o token correspondente.

~~~haskell
-- Lexer.x
{
-- Esta é a primeira seção: Código Haskell.
-- Ele será copiado literalmente para o início do arquivo Lexer.hs gerado.
module Lexer (alexScanTokens) where
import Tokens

}

%wrapper "basic"

-- AQUI COMEÇA A SEGUNDA SEÇÃO: Definições do Alex

$digit = 0-9
$alpha = [a-zA-Z]

-- AQUI COMEÇA A TERCEIRA SEÇÃO: Regras de Tokenização

tokens :-

  -- Ignorar espaços em branco (sem ação)
  \s+ ;

  -- Palavras-chave
  "if"            { \_ -> TIf }
  "else"          { \_ -> TElse }
  "while"         { \_ -> TWhile }
  "print"         { \_ -> TPrint }
  "read"          { \_ -> TRead }
  "return"        { \_ -> TReturn }
  "int"           { \_ -> TInt }
  "double"        { \_ -> TDouble }
  "string"        { \_ -> TString }
  "void"          { \_ -> TVoid }

  -- Identificadores (começa com letra, seguido por letras ou dígitos)
  $alpha[$alpha$digit]*  { \s -> TId s }

  -- Constantes
  $digit+         { \s -> TConsInt (read s) }
  $digit+\.$digit+ { \s -> TConsDouble (read s) }
  \"[^\"]*\"      { \s -> TLiteral (init (tail s)) } -- Remove as aspas

  -- Operadores e Pontuação
  "+"             { \_ -> TPlus }
  "-"             { \_ -> TMinus }
  "*"             { \_ -> TMult }
  "/"             { \_ -> TDiv }
  "="             { \_ -> TAssign }
  "=="            { \_ -> TEq }
  "/="            { \_ -> TNeq }
  "<"             { \_ -> TLt }
  "<="            { \_ -> TLe }
  ">"             { \_ -> TGt }
  ">="            { \_ -> TGe }
  "&&"            { \_ -> TAnd }
  "||"            { \_ -> TOr }
  "!"             { \_ -> TNot }
  "("             { \_ -> TLparen }
  ")"             { \_ -> TRparen }
  "{"             { \_ -> TLbrace }
  "}"             { \_ -> TRbrace }
  ","             { \_ -> TComma }
  ";"             { \_ -> TSemicolon }
~~~

Obs: Linhas como: 

        "if" { \_ -> TIf } 

são regras de tradução que dizem ao seu compilador:
"Quando você estiver lendo o código fonte e encontrar os caracteres 'i' e 'f' (no exemplo dado) juntos, consuma-os e, em vez deles, gere uma única unidade de informação: o token TIf, que representa a palavra-chave 'if' da linguagem."

## Passo 2: Análise Sintática com Happy (A "Gramática" da Linguagem)


O analisador sintático, ou parser, verifica a sequência de tokens. O Happy gera esse parser a partir de um arquivo de especificações (.y). Ele vai usar os tokens de Lexer.x e a AST que foi fornecida na descrição do trabalho.

### 2.1. Organizaremos nossa AST da seguinte forma

~~~haskell
-- Ast.hs
module Ast where
-- Cole aqui exatamente as definições de Id, Tipo, TCons, Expr, etc.
-- que foram fornecidas no enunciado do trabalho.
type Id = String
data Tipo = TDouble | TInt | TString | TVoid deriving (Show, Eq)
-- ... e assim por diante para todas as outras definições.
~~~

### 2.2. Crie o Arquivo do Happy (Parser.y)
Este arquivo também tem seções:

- **Cabeçalho:** Importações, incluindo seus módulos Tokens e Ast.
- **Declarações do Happy:**
        
        %name: O nome da função de parsing a ser gerada.
        %tokentype: O tipo de dado que representa os tokens ({Token}).
        %token: Mapeia os tokens do Alex para os terminais da gramática.
        %left, %right, %nonassoc: Essencial para definir precedência e associatividade de operadores!

- **Regras da Gramática:** A tradução da gramática do seu trabalho para o formato do Happy, com ações em Haskell {...} para construir a AST.


~~~haskell
-- Parser.y
{
module Parser where
import Tokens
import Ast
}

%name parsePrograma Programa
%tokentype { Token }
%error { parseError }

-- Declaração dos tokens (terminais)
%token
  TIf         { TIf }
  TElse       { TElse }
  TWhile      { TWhile }
  -- ... (declare todos os outros tokens de Tokens.hs) ...
  TId         { TId $$ }
  TConsInt    { TConsInt $$ }
  TConsDouble { TConsDouble $$ }
  TLiteral    { TLiteral $$ }
  TAssign     { TAssign }
  -- ... etc ...

-- Precedência e Associatividade de operadores
-- (Menor precedência no topo, maior no final)
%left TOr
%left TAnd
%nonassoc TEq TNeq TLt TLe TGt TGe
%left TPlus TMinus
%left TMult TDiv
%right TNot -- unário com maior precedência

-- A "raiz" da gramática e seu tipo de retorno na AST
%%

-- A partir daqui, você traduz a gramática do trabalho.
-- $1, $2, etc., referem-se aos resultados das partes da regra.
-- Ex: em "id = <Expr>", o id é $1 e o <Expr> é $3.

Programa :: { Programa }
  : <ListaFuncoes> <BlocoPrincipal> { Prog $1 [] [] $2 } -- Simplificado por enquanto
  | <BlocoPrincipal>               { Prog [] [] [] $1 } -- Simplificado

BlocoPrincipal :: { Bloco }
  : TLbrace TListaCmd TRbrace { $2 }
  -- Adicione a regra com <Declaracoes> aqui.

ListaCmd :: { [Comando] }
  : ListaCmd Comando  { $1 ++ [$2] }
  | Comando           { [$1] }

Comando :: { Comando }
  : CmdAtrib { $1 }

CmdAtrib :: { Comando }
  : TId TAssign ExprAritmetica TSemicolon { Atrib $1 $3 }
  | TId TAssign TLiteral       TSemicolon { Atrib $1 (Lit $3) }

-- Exemplo para uma expressão aritmética simples
ExprAritmetica :: { Expr }
  : ExprAritmetica TPlus ExprAritmetica  { Add $1 $3 }
  | ExprAritmetica TMinus ExprAritmetica { Sub $1 $3 }
  | ExprAritmetica TMult ExprAritmetica { Mul $1 $3 }
  | ExprAritmetica TDiv ExprAritmetica   { Div $1 $3 }
  | TId                                  { IdVar $1 }
  | TConsInt                             { Const (CInt $1) }
  | TConsDouble                          { Const (CDouble $1) }
  | TLparen ExprAritmetica TRparen       { $2 }

-- ... você precisa continuar e traduzir TODAS as regras da sua gramática.
-- Lembre-se que cada regra não-terminal (ex: <CmdSe>) deve ter seu
-- tipo de retorno Haskell especificado na seção de declarações, assim:
-- %type <Comando> { CmdSe CmdEnquanto ... }
-- %type <Expr>    { ExprAritmetica }
~~~

**Dica Crucial:** A tradução da gramática é a parte mais trabalhosa. Vá regra por regra. Por exemplo, para <CmdSe>, você faria algo como:

~~~haskell
CmdSe :: { Comando }
  : TIf TLparen ExprLogica TRparen Bloco { If $3 $5 [] }
  | TIf TLparen ExprLogica TRparen Bloco TElse Bloco { If $3 $5 $7 }
~~~

## Passo 3: Juntando Tudo e Compilando

Agora você tem Tokens.hs, Ast.hs, Lexer.x e Parser.y. Crie um arquivo Main.hs para orquestrar o processo.

~~~haskell
-- Main.hs
import System.Environment (getArgs)
import Lexer (alexScanTokens)
import Parser (parsePrograma)
import Ast (Programa)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [fileName] -> do
      sourceCode <- readFile fileName
      let tokens = alexScanTokens sourceCode
      -- Para depurar, você pode imprimir os tokens:
      -- print tokens
      let ast = parsePrograma tokens
      -- Imprime a AST resultante
      print ast
    _ -> putStrLn "Uso: ./seu_compilador <arquivo_fonte>"

-- Função de erro para o Happy
parseError :: [Token] -> a
parseError t = error ("Erro de sintaxe perto de: " ++ show t)
~~~

**Para compilar e executar:**

1. **Instale as ferramentas**
Usando cabal
~~~Bash
cabal update
cabal install alex happy
~~~
ou usando o próprio apt-get (sujeito a instalar versões antigas)
~~~Bash
sudo apt-get update
sudo apt-get install alex happy
~~~

2. **Gere o código Haskell a partir de Alex e Happy:**
~~~Bash
alex Lexer.x    -- Gera Lexer.hs
happy Parser.y  -- Gera Parser.hs
~~~

3. **Compile todo o projeto com o GHC:**
~~~Bash
ghc --make Main.hs -o meucompilador
~~~

4. **Execute:**
Crie um arquivo de teste teste.txt com um código simples da sua linguagem, como { id = 5; }.

~~~Bash
./meucompilador teste.txt
~~~
