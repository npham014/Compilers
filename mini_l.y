%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char* msg);
extern int lineNum;
extern int colNum;
FILE * yyin;
%}
%union {
int value;
const char* name;
}

%start program
%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN
%token <name> IDENT
%token <value> NUMBER
%right ASSIGN
%left OR
%left AND
%right NOT
%left GT LT LTE GTE EQ NEQ
%left ADD SUB
%left MULT DIV MOD
 
%%

program: functs {printf("program -> functs\n");}
;
functs: %empty {printf("functs -> epsilon\n");}
| funct functs {printf("functs -> funct functs\n");}
;
funct: FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY {printf("funct -> FUNCTION IDENT %s SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n", $2);}
;
declarations: %empty {printf("declarations -> epsilon\n");}
| declaration SEMICOLON declarations {printf("declaration -> declaration SEMICOLON declarations\n");}
;
declaration: identifier COLON assigning {printf("declaration -> identifier COLON assigning\n");}
;
identifier: IDENT {printf("identifier -> IDENT %s\n", $1);}
| IDENT COMMA identifier { printf("identifier -> IDENT %s COMMA identifier\n", $1);}
;
assigning: INTEGER {printf("assigning -> INTEGER\n");}
| ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("assigning -> ARRAY L_SQUARE_BRACKET NUMBER %d R_SQUARE_BRACKET OF INTEGER\n", $3);}
;
statements: statement SEMICOLON statements {printf("statements -> statement SEMICOLON statements\n");}
|%empty {printf("statements -> epsilon\n");}
;
statement: var ASSIGN expr {printf("statement -> var ASSIGN expr\n");}
| IF boolExpr THEN statements ENDIF {printf("statement -> IF boolExpr THEN statements ENDIF\n");}
| IF boolExpr THEN statements ELSE statements ENDIF {printf("statement -> IF boolExpr THEN statements ELSE statements ENDIF\n");}
| WHILE boolExpr BEGINLOOP statements ENDLOOP {printf("statement -> WHILE boolExpr BEGINLOOP statements ENDLOOP\n");}
| DO BEGINLOOP statements ENDLOOP WHILE boolExpr {printf("statement -> DO BEGINLOOP statements ENDLOOP WHILE boolExpr\n");}
| READ vars {printf("statement -> READ variables\n");}
| WRITE vars {printf("statement -> WRITE variables\n");}
| CONTINUE {printf("statement -> CONTINUE\n");}
| RETURN expr {printf("statement -> RETURN expr\n");}
;
boolExpr: relAndExpr {printf("boolExpr -> relAndExpr\n");}
| relAndExpr OR boolExpr {printf("boolExpr -> relAndExpr OR boolExpr\n");}
;
relAndExpr: relExpr {printf("relAndExpr -> relExpr\n");}
| relExpr AND relAndExpr {printf("relAndExpr -> relExpr AND relAndExpr\n");}
;
relExpr: notRelExpr {printf("relExpr -> notRelExpr\n");}
| regRelExpr {printf("relExpr -> regRelExpr\n");}
;
notRelExpr: NOT regRelExpr {printf("notRelExpr -> NOT regRelExpr\n");}
;
regRelExpr: expr comp expr {printf("regRelExpr -> expr comp expr\n");}
| TRUE {printf("regRelExpr -> TRUE\n");}
| FALSE {printf("regRelExpr -> FALSE\n");}
| L_PAREN boolExpr R_PAREN {printf("regRelExpr -> L_PAREN boolExpr R_PAREN\n");}
;
comp: EQ {printf("comp -> EQ\n");}
| NEQ {printf("comp -> NEQ\n");}
| LT {printf("comp -> LT\n");}
| GT {printf("comp -> GT\n");}
| LTE {printf("comp -> LTE\n");}
| GTE {printf("comp -> GTE\n");}
;
expr: multExpr {printf("expr -> multExpr\n");}
| expr ADD multExpr {printf("expr -> expr ADD multExpr\n");}
| expr SUB multExpr {printf("expr -> expr SUB multExpr\n");}
;
multExpr: term {printf("multExpr -> term\n");}
| multExpr MULT term {printf("multExpr -> multExpr MULT term\n");}
| multExpr DIV term {printf("multExpr -> multExpr DIV term\n");}
| multExpr MOD term {printf("multExpr -> multExpr MOD term");}
;
term: valTerm {printf("term -> valTerm\n");}
| idTerm {printf("term -> idTerm\n");}
;
valTerm: posTerm {printf("valTerm -> posTerm\n");}
| negTerm {printf("valTerm -> negTerm\n");}
;
negTerm: SUB posTerm {printf("negTerm -> SUB posTerm\n");}
;
posTerm: var {printf("posTerm -> var\n");}
| NUMBER {printf("posTerm -> NUMBER\n");}
| L_PAREN expr R_PAREN {printf("posTerm -> L_PAREN expression R_PAREN\n");}
;
idTerm: identifier L_PAREN exprs R_PAREN {printf("idTerm -> identifier L_PAREN exprs R_PAREN\n");}
;
exprs: expr COMMA exprs {printf("exprs -> expr COMMA exprs\n");}
| expr {printf("exprs -> expr\n");}
;
vars: var vars {printf("vars -> var vars\n");}
| var {printf("vars -> var\n");}
;
var: identifier L_SQUARE_BRACKET expr R_SQUARE_BRACKET {printf("var -> identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
|identifier {printf("var -> identifier\n");}
;
%%
 
