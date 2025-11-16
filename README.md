
# Compilador Java

![img](https://optim.tildacdn.net/tild6638-3234-4266-b630-646530643738/-/resize/760x/-/format/webp/compiler.jpg.webp)

Antes de mais nada, construir um compilador é um dos projetos mais clássicos e gratificantes da Ciência da Computação. O uso de Haskell com as ferramentas Alex e Happy é uma escolha fantástica, pois a linguagem é extremamente adequada para a manipulação de estruturas de dados em árvore, como a sua Árvore Sintática Abstrata (AST).

O processo de compilação é classicamente dividido em fases. Para a nossa primeira etapa do trabalho, iremos focar nas duas primeiras: Análise Léxica e Análise Sintática.

## Passo 0: Entendendo a Arquitetura do Compilador


Antes de escrever qualquer código, é crucial entender o fluxo de dados:
1. **Código Fonte** (arquivo .txt): if (a > 5) { print(a); }

2. **Analisador Léxico (Alex):** Transforma o texto em uma sequência de "tokens". Pense neles como as "palavras" da linguagem.
    
        [TIF,LPAR,ID "a",MAJOR,CINT 5,RPAR,LCBRAK,TPRINT,LPAR,ID "a",RPAR,SEMICOLON,RCBRAK]

3. **Analisador Sintático (Happy):** Recebe os tokens e verifica se eles formam "frases" válidas de acordo com a gramática. Se a sintaxe estiver correta, ele monta a Árvore Sintática Abstrata (AST).
    
        If (Rel (Rgt (IdVar "a") (Const (CInt 5)))) [Imp (IdVar "a")] []

4. **Analisador Semântico:** Percorre a AST para verificar o significado e as regras de tipo (ex: você não pode somar uma string com um inteiro).

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

  {
-- Função para testar se a tokenização está correta
testLexer = do 
  putStr "Digite o código que deseja tokenizar: "
  s <- getLine
  print (alexScanTokens s)
  }
~~~

Obs: Linhas como: 

        "if" { \_ -> TIf } 

são regras de tradução que dizem ao seu compilador:
"Quando você estiver lendo o código fonte e encontrar os caracteres 'i' e 'f' (no exemplo dado) juntos, consuma-os e, em vez deles, gere uma única unidade de informação: o token TIf, que representa a palavra-chave 'if' da linguagem."

## Passo 2: Análise Sintática com Happy (A "Gramática" da Linguagem)


O analisador sintático, ou parser, verifica a sequência de tokens. O Happy gera esse parser a partir de um arquivo de especificações (.y). Ele vai usar os tokens de Lexer.x e a AST que foi fornecida na descrição do trabalho.

### 2.1. Organizaremos nossa AST da seguinte forma

~~~haskell
-- AST.hs
module AST where
-- Aqui vão exatamente as definições de Id, Tipo, TCons, Expr.. que foram fornecidas no enunciado do trabalho.
module AST where

type Id = String

data Tipo   = TDouble
            | TInt
            | TString
            | TVoid
            deriving (Show, Eq)

data TCons  = CDouble Double
            | CInt Int
            deriving Show

data Expr   = Add Expr Expr 
            | Sub Expr Expr
            | Mul Expr Expr
            | Div Expr Expr
            | Neg Expr
            | Const TCons
            | IdVar String
            | Chamada Id [Expr]
            | Lit String
            | IntDouble Expr
            | DoubleInt Expr
            deriving Show
data ExprR = ...

--- O restante das derivações
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

-- GRAMÁTICA

-- EXPRESSÕES

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
  
  ...

-- DEFINIÇÕES DA LINGUAGEM

Programa  : ListaFuncoes BlocoPrincipal {case $2 of
                                         BlocoPrinc v c -> Prog (map (funcaoDeFundef) $1) (map (defDeFundef) $1) v c}
          | BlocoPrincipal {case $1 of
                           BlocoPrinc v c -> Prog [] [] v c}

ListaFuncoes  : ListaFuncoes Funcao   {$1 ++ [$2]}  -- Lista de FunDefs
              | Funcao                {[$1]}

...

CmdEnquanto : while '(' ExprL ')' Bloco { While $3 $5 }

CmdAtrib  : id '=' Expr ';'     {Atrib $1 $3}
          | id '=' literal ';'  {Atrib $1 (Lit $3)}

CmdEscrita  : print '(' Expr ')' ';'    {Imp $3} 
            | print '(' literal ')' ';' {Imp (Lit $3)}

...

-- Função de teste para o seu Parser
testeParser = do putStr "Qual arquivo voce quer ler? "
          arquivo <- getLine
          s <- readFile arquivo
          print (calc (L.alexScanTokens s))

~~~

**Dica Crucial:** A tradução da gramática é uma parte bemtrabalhosa. Vá regra por regra e entenda o que está acontecendo. Por exemplo, para <CmdSe>, você faria algo como:

~~~haskell
CmdSe : if '(' ExprL ')' Bloco            {If $3 $5 []} -- Regra 1: if-then
      | if '(' ExprL ')' Bloco else Bloco {If $3 $5 $7} -- Regra 2: if-then-else
~~~
### A Estratégia: O Mapeamento $N

**Regra 1:** A variável $N acessa o valor do N-ésimo símbolo à direita da regra.

Para a Regra 1: if '(' ExprL ')' Bloco

$1: O token if

$2: O token '('

$3: O valor da ExprL (a condição, já processada pela sua própria regra)

$4: O token ')'

$5: O valor do Bloco (o bloco "then", já processado)

**Regra 2:** Mesma idéia.

## Passo 4: Analisador Semântico

Antes de seguirmos para a parte semântica, é recomendado que teste Lexer.x e Parser.y usando [alex e happy]() e executando suas funções de teste. 

~~~Haskell
module Semantico where
import Control.Monad (zipWithM)

import AST

-- AQUI COMEÇA A IDEIA DE MÔNODAS

data Result a = Result (Bool, String, a) deriving Show

instance Functor Result where
  fmap f (Result (b, s, a)) = Result (b, s, f a)

instance Applicative Result where
  pure a = Result (False, "", a)
  Result (b1, s1, f) <*> Result (b2, s2, x) = Result (b1 || b2, s1 <> s2, f x)   

instance Monad Result where 
--  return a = Result (False, "", a)
  Result (b, s, a) >>= f = let Result (b', s', a') = f a
                           in Result (b || b', s++s', a')
  
errorMsg s = Result (True, "Erro: "++s++"\n", ())

warningMsg s = Result (False, "Advertencia: "++s++"\n", ())

-- IMPLEMENTAÇÕES 

-- Verifica a existência de uma variável, caso positivo retorna seu tipo.

buscaVar [] nome = do {
  errorMsg ("Variavel nao declarada: " ++ show nome);
  return (TVoid, IdVar nome)
 }
buscaVar ((nomeVar :#: (tipo,_)) : resto) nome
  | nomeVar == nome = return (tipo, IdVar nome)
  | otherwise = buscaVar resto nome

-- Verifica a existência de uma função, caso positivo retorna seus parâmetros e o tipo de retorno.
...


-- Funções de teste para o Semântico
testSemantico1 = Prog
  [ "maior" :->:
      ( [ "a" :#: (TDouble, 0)
        , "b" :#: (TDouble, 0)
        ]
      , TDouble
      )
  ]
  [ ( "maior"
    , [ "m" :#: (TInt, 0)
      , "a" :#: (TDouble, 0)
      , "b" :#: (TDouble, 0)
      ]
    , [ If (Rel (Rgt (IdVar "a") (IdVar "b")))
          [ Atrib "m" (IdVar "a") ]
          [ Atrib "m" (IdVar "b") ]
      , Ret (Just (IdVar "m"))
      ]
    )
  ]
  [ "a" :#: (TInt, 0) ]
  [ Atrib "a" (Chamada "maior"
      [ Const (CDouble 2.5)
      , Const (CInt 10)
      ])
  , Ret (Just (Const (CInt 0)))
  ]
~~~

## Passo 5: Gerador de código e Orquestrador final

O gerador de código...

~~~Haskell
module Code_generator where

import AST
import Control.Monad.State

novoLabel :: State Int String 
novoLabel = do {n <- get; put (n+1); return ("l" ++ show n)}

genCab :: String -> State Int String
genCab nome = return (".class public " ++ nome ++ 
                      "\n.super java/lang/Object\n\n.method public <init>()V\n\taload_0\n\tinvokenonvirtual java/lang/Object/<init>()V\n\treturn\n.end method\n\n")

genMainCab :: Int -> Int -> State Int String
genMainCab s l = return (".method public static main([Ljava/lang/String;)V" ++
                         "\n\t.limit stack " ++ show s ++
                         "\n\t.limit locals " ++ show l ++ "\n\n")

-- Geração de expressões aritméticas 

genCmd :: [Funcao] -> [Var] -> Comando -> State Int String
genExpr fun tab (Const (CInt i)) = return (TInt, genInt i)
genExpr fun tab (Const (CDouble d)) = return (TDouble, genDouble d)
genExpr fun tab (IdVar v) = case lookupVar v tab of
  Just (TInt, n)    -> return (TInt, "\tiload " ++ show n ++ "\n")
  Just (TDouble, n) -> return (TDouble, "\tdload " ++ show n ++ "\n")
  Just (TString, n) -> return (TString, "\taload " ++ show n ++ "\n")
  _                 -> error ("Variável não encontrada ou tipo inválido: " ++ v)

-- Exemplo de geração de um código while

genCmd fun tab (While cond bloco) = do
  lInicio <- novoLabel
  lTrue   <- novoLabel
  lFim    <- novoLabel
  cond'   <- genExprL fun tab lTrue lFim cond
  bloco'   <- genBloco fun tab bloco
  return $
    lInicio ++ ":\n" ++
    cond' ++
    lTrue ++ ":\n" ++
    bloco' ++
    "\tgoto " ++ lInicio ++ "\n" ++
    lFim ++ ":\n"

--- Restante das gerações ----
...

~~~

O Orquestrador final (nossa Main)....

~~~Haskell
module Main where
import AST
import Control.Monad.State
import Lexer
import Parser
import Semântico
import Code_generator
import System.Process (system)
import System.FilePath ((</>))

main = do
  putStr "Qual arquivo voce quer ler? "
  arquivo <- getLine
  s <- readFile arquivo
  let parsed = Parser.calc (Lexer.alexScanTokens s)
  let Result (houveErro, mensagens, progVerificado) = Semântico.tProg parsed
  putStrLn mensagens
  if houveErro
    then putStrLn "Houve erro(s) semantico(s). Nao e possível gerar codigo intermediario"
    else do
      putStrLn "Analise semantica ok!\n"
      let Prog funcoes definicoes variaveis bloco = progVerificado
      let variaveisIndexadas = atribuirIndicesVariaveis 0 variaveis
      let definicoesIndexadas = map indexarVariaveisFuncao definicoes
      let progComIndices = Prog funcoes definicoesIndexadas variaveisIndexadas bloco
      print progComIndices

--- Restante da implementação ---
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


## Adicionando um For

Entender toda a implementação de um compilador é uma tarefa relativamente complexa, então a melhor maneira iniciar o aprendizado é, a partir desse código, adicionar um novo comando da linguagem java. 

Aqui vou mostrar o passo a passo de como seria implementar um for e sua lógica. Pois, adicionar uma funcionalidade do zero é a prova de fogo para entender como as peças (Léxico, Sintático, Semântico e Geração de Código) se encaixam.

Vamos implementar o for no estilo C/Java: 
for (i = 0; i < 10; i = i + 1) { ... }.

### Passo 1: A Estrutura (O "Molde" na AST)

Antes de qualquer coisa, precisamos definir como o compilador enxerga um for. Ele precisa guardar quatro informações: a inicialização, a condição, o incremento e o bloco de código.

Arquivo: RI.hs

Modifique o tipo Comando para incluir o construtor do For.

~~~Haskell

data Comando = If ExprL Bloco Bloco
             | While ExprL Bloco
             -- O NOVO COMANDO:
             | For Comando ExprL Comando Bloco 
             | Atrib Id Expr
             ...
~~~
Ponto Crucial: Note que a inicialização (i=0) e o incremento (i=i+1) são do tipo Comando, enquanto a condição (i < 10) é ExprL (Expressão Lógica). Isso define estritamente o que é permitido escrever dentro dos parênteses.

### Passo 2: A Gramática (Ensinando o Parser)

Agora precisamos ensinar o compilador a reconhecer a frase "for parênteses ponto-e-vírgula...". Isso é feito no arquivo do Parser (normalmente Parser.y).

Arquivo: Parser.y

Você adicionará uma regra na seção de Comando:

~~~Haskell

Comando : CmdSe {$1}
        | CmdEnquanto {$1}
        | CmdDurante  {$1} -- Novo comando FOR
        | CmdAtrib    {$1}
        | CmdEscrita  {$1}
        | CmdLeitura  {$1}
        | ChamadaProc {$1}
        | Retorno     {$1}


CmdDurante : for '(' CmdAtribFor ';' ExprL ';' CmdAtribFor ')' Bloco { For $3 $5 $7 $9 } 

CmdAtribFor  : id '=' Expr  {Atrib $1 $3}
          | id '=' literal      {Atrib $1 (Lit $3)} -- Criar uma atribuição simples, como i = 0 (sem o ;) apenas para o FOR.

~~~
Ponto Crucial: A ordem importa. $3 é a inicialização, $5 é a condição, $7 é o incremento e $9 é o bloco. Estamos pegando o texto e convertendo no "Molde" que criamos no Passo 1. 

### Passo 3: O Significado (Análise Semântica)

O compilador já sabe ler o for, mas ele precisa saber se o for faz sentido (ex: se as variáveis existem, se a condição é booleana, etc.).

Arquivo: Semantico.hs

Precisamos adicionar um caso na função tComando. A lógica é recursiva: "Analise a inicialização, depois a condição, depois o incremento e por fim o bloco".

~~~Haskell

tComando contexto tfun tvar (For init cond inc bloco) = do
  init'  <- tComando contexto tfun tvar init  -- Verifica se 'i=0' é válido
  cond'  <- tExprL tfun tvar cond       -- Verifica se 'i<10' retorna booleano
  inc'   <- tComando contexto tfun tvar inc   -- Verifica se 'i=i+1' é válido
  bloco' <- tBloco contexto tfun tvar bloco -- Verifica o conteúdo do loop

~~~
  
  -- Retorna a versão verificada (importante para coerções de tipos!)
  return (For init' cond' inc' bloco')
Ponto Crucial: Não descarte o resultado das análises (init', cond', etc.). Se o semântico decidir transformar um Int em Double (coerção), essa mudança estará armazenada nessas novas variáveis. Se você retornar o init original, perderá essa correção.

### Passo 4: A Geração de Código (A "Tradução")
Esta é a parte mais complexa. Precisamos transformar essa estrutura em instruções de baixo nível (Assembly/Jasmin) que usam GOTO (pulos).

A Lógica do Fluxo: Diferente do código fonte, onde o incremento está no topo, na execução ele acontece no final do loop.

Arquivo: Intermediario.hs

~~~Haskell

genCmd fun tab (For init cond inc bloco) = do
  -- 1. A Inicialização roda apenas uma vez, antes de tudo.
  init' <- genCmd fun tab init

  -- 2. Criamos etiquetas (labels) para marcar os lugares do código
  lInicio <- novoLabel  -- Onde começa o teste a cada volta
  lTrue   <- novoLabel  -- Onde começa o código se o teste for verdadeiro
  lFim    <- novoLabel  -- Para onde vamos se o teste for falso

  -- 3. Geramos o código da condição
  -- Ele deve pular para lTrue se OK, ou lFim se falhar
  cond'   <- genExprL fun tab lTrue lFim cond

  -- 4. Geramos o corpo do loop
  bloco'  <- genBloco fun tab bloco

  -- 5. Geramos o incremento
  inc'    <- genCmd fun tab inc

  -- 6. MONTANDO O QUEBRA-CABEÇA:
  return $
    init' ++                -- i = 0
    lInicio ++ ":\n" ++     -- MARCA: Começo do loop
    cond' ++                -- if (i >= 10) goto lFim
    lTrue ++ ":\n" ++       -- MARCA: Entrada do bloco
    bloco' ++               -- executa código...
    inc' ++                 -- i = i + 1 (Incremento acontece aqui!)
    "\tgoto " ++ lInicio ++ "\n" ++ -- Volta para testar de novo
    lFim ++ ":\n"           -- MARCA: Saída
~~~
Ponto Crucial: Perceba onde o inc' foi colocado? Ele fica após o bloco e antes do goto lInicio. É isso que faz o loop funcionar corretamente.
