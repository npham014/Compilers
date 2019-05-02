/***Definitions***/

%{
#include "y.tab.h"
#include <string.h>
int minusCount = 0;
int plusCount = 0;
int equalsCount = 0;
int multCount = 0;
int divCount = 0;
int lParCount = 0;
int rParCount = 0;
int intCount = 0;
int curCol = 0;
int curLine = 1;
%}
DIGIT [0-9]
LOWLETTER [a-z]
CAPLETTER [A-Z]
/***Rules***/
%%
{DIGIT}+("."{DIGIT}+)?[eE][+-]?{DIGIT}+ {/*printf("SCINOTATION %s\n", yytext);*/ curCol += yyleng;}
({DIGIT}+)?"."{DIGIT}+ {/*printf("DECIMAL %s\n", yytext);*/ curCol += yyleng;}
{DIGIT}+ {/*printf("NUMBER %s\n", yytext); */intCount++; yylval = atoi(yytext); curCol += yyleng; return INTNUM;}
"-" {/*printf("MINUS\n");*/ minusCount++;curCol += yyleng; return MINUS;}
"+" {/*printf("PLUS\n");*/ plusCount++; curCol += yyleng; return PLUS;}
"=" {/*printf("EQUALS\n");*/ equalsCount++; curCol += yyleng; return EQU;}
"*" {/*printf("MULT\n");*/ multCount++; curCol += yyleng; return MULT;}
"/" {/*printf("DIV\n");*/ divCount++; curCol += yyleng;return DIV;}
"(" {/*printf("L_PAREN\n");*/lParCount++; curCol += yyleng;return L_PAREN;}
")" {/*printf("R_PAREN\n");*/rParCount++; curCol += yyleng;return R_PAREN;}
" " {curCol += yyleng;}
"\t" {curCol += yyleng;}
"\n" {curLine++; curCol = 0;return ENDL;} 
{LOWLETTER}+ {printf("Letters are not recognized by Calculator. Exiting"); exit(0);}
{CAPLETTER}+ {printf("Letters are not recognized by Calculator. Exiting"); exit(0);}
. {printf("Unrecognized Symbol:%s. Exiting",yytext); exit(0);}

%%
int yywrap() {
	return 1;
}
int main(int argc, char** argv) {
	if(argc > 1) {
		yyin = fopen(argv[1], "r");
	}
	else {
		yyin = stdin;
	}
	yyparse();
	/*printf ("Num Integers: %d\n", intCount);
	printf("Num Minus: %d\n", minusCount);
	printf("Num Plus: %d\n", plusCount);
	printf("Num Equals: %d\n", equalsCount);
	printf("Num Mult: %d\n", multCount);
	printf("Num Div: %d\n", divCount);
	printf("Left Parentheses Count: %d\n", lParCount);
	printf("Right Parentheses Count: %d\n", rParCount);*/
	return 0;
}

void yyerror (const char* msg) {
	printf("Error at Line %d, Column %d. %s", curLine, curCol,msg);
	exit(0);
	return;
}

