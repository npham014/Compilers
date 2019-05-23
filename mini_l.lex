/*** Definitions ***/
%{
#include "y.tab.h"
#include <string.h>
int lineNum = 0;
int colNum = 0;
%}

CHAR [a-zA-Z]
DIGIT [0-9]
/*** RULES ***/

%%
"function" {colNum += yyleng; return FUNCTION;}
"beginparams" {colNum += yyleng; return BEGIN_PARAMS;}
"endparams" {colNum += yyleng; return END_PARAMS;}
"beginlocals" { colNum += yyleng; return BEGIN_LOCALS;}
"endlocals" {colNum += yyleng; return END_LOCALS;}
"beginbody" {colNum += yyleng; return BEGIN_BODY;}
"endbody" {colNum += yyleng; return END_BODY;}
"integer" {colNum += yyleng; return INTEGER;}
"array" {colNum += yyleng; return ARRAY;}
"of" {colNum += yyleng; return OF;}
"if" {colNum += yyleng; return IF;}
"then" {colNum += yyleng;return THEN;}
"endif" {colNum += yyleng; return ENDIF;}
"else" {colNum += yyleng;return ELSE;}
"while" {colNum += yyleng;return WHILE;}
"do" {colNum += yyleng;return DO;}
"beginloop" {colNum += yyleng;return BEGINLOOP;}
"endloop" {colNum += yyleng;return ENDLOOP;}
"continue" {colNum += yyleng;return CONTINUE;}
"read" {colNum += yyleng;return READ;}
"write" {colNum += yyleng;return WRITE;}
"and" {colNum += yyleng;return AND;}
"or" {colNum += yyleng;return OR;}
"not" {colNum += yyleng;return NOT;}
"true" {colNum += yyleng;return TRUE;}
"false" {colNum += yyleng;return FALSE;}
"return" {colNum += yyleng;return RETURN;}
"-" {colNum += yyleng;return SUB;}
"+" {colNum += yyleng;return ADD;}
"*" {colNum += yyleng;return MULT;}
"/" {colNum += yyleng;return DIV;}
"%" {colNum += yyleng;return MOD;}
"==" {colNum += yyleng;return EQ;}
"<>" {colNum += yyleng;return NEQ;}
"<" {colNum += yyleng;return LT;}
">" {colNum += yyleng;return GT;}
"<=" {colNum += yyleng;return LTE;}
">=" {colNum += yyleng;return GTE;}
";" {colNum += yyleng;return SEMICOLON;}
":" {colNum += yyleng;return COLON;}
"," {colNum += yyleng;return COMMA;}
"(" {colNum += yyleng;return L_PAREN;}
")" {colNum += yyleng;return R_PAREN;}
"[" {colNum += yyleng;return L_SQUARE_BRACKET;}
"]" {colNum += yyleng;return R_SQUARE_BRACKET;}
":=" {colNum += yyleng;return ASSIGN;}
(##.*\n) {lineNum++;colNum = 0;}
{DIGIT}+ {yylval.value = atoi(yytext);colNum += yyleng; return NUMBER;}
{CHAR} {colNum += yyleng;return IDENT;}
({CHAR}+(_|{DIGIT}|{CHAR})*)+({DIGIT}|{CHAR}) {yylval.name = yytext;colNum += yyleng; return IDENT;}
(_+{CHAR}+) {yyerror("Identifier cannot begin with underscore.");}
({CHAR}+_+) {yyerror("Identifier cannot end with underscore.");}
({DIGIT}+{CHAR}+) {yyerror("Identifier must begin with letter.");}
" " {colNum += yyleng;}
"\t" {colNum += yyleng;}
"\n" {lineNum++;colNum = 0;}
. {printf("Error at line %d, column %d: unrecognized symbol \'%s\'", lineNum, colNum, yytext);exit(1);}
%%

int yywrap() {
	return 1;
}

int main (int argc, char ** argv) {
	if(argc >= 2) {
		yyin = fopen(argv[1], "r");
		if(yyin == NULL) {
			yyin = stdin;
		}
	}
	else {
		yyin = stdin;
	}
	yyparse();
	return 0;
}
void yyerror(const char* msg) {
	printf("Error at line %d, Column %d. %s", lineNum, colNum, msg);
	exit(1);
	return;
}
