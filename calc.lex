/***Definitions***/
%{
int minusCount = 0;
int plusCount = 0;
int equalsCount = 0;
int multCount = 0;
int divCount = 0;
int lParCount = 0;
int rParCount = 0;
int intCount = 0;
%}
DIGIT [0-9]
LOWLETTER [a-z]
CAPLETTER [A-Z]
/***Rules***/
%%
{DIGIT}+("."{DIGIT}+)?[eE][+-]?{DIGIT}+ {printf("SCINOTATION %s\n", yytext);}
({DIGIT}+)?"."{DIGIT}+ {printf("DECIMAL %s\n", yytext);}
{DIGIT}+ {printf("NUMBER %s\n", yytext);intCount++;}
"-" {printf("MINUS\n"); minusCount++;}
"+" {printf("PLUS\n"); plusCount++;}
"=" {printf("EQUALS\n"); equalsCount++;}
"*" {printf("MULT\n"); multCount++;}
"/" {printf("DIV\n"); divCount++;}
"(" {printf("L_PAREN\n");lParCount++;}
")" {printf("R_PAREN\n");rParCount++;}
" " {}
"\t" {}
"\n" {} 
{LOWLETTER}+ {printf("Letters are not recognized by Calculator. Exiting"); exit(0);}
{CAPLETTER}+ {printf("Letters are not recognized by Calculator. Exiting"); exit(0);}
. {printf("Unrecognized Symbol. Exiting"); exit(0);}

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
	yylex();
	printf ("Num Integers: %d\n", intCount);
	printf("Num Minus: %d\n", minusCount);
	printf("Num Plus: %d\n", plusCount);
	printf("Num Equals: %d\n", equalsCount);
	printf("Num Mult: %d\n", multCount);
	printf("Num Div: %d\n", divCount);
	printf("Left Parentheses Count: %d\n", lParCount);
	printf("Right Parentheses Count: %d\n", rParCount);
	return 0;
}


