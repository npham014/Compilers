%{
/*prologue*/
#include <stdio.h>
#include <stdlib.h>
%}
/*bison declarations*/
%token INTNUM PLUS EQU ENDL MULT DIV L_PAREN R_PAREN MINUS
%left PLUS MINUS
%left MULT DIV

%%
/* rules */
start: 
	| start output
	;
output: exp EQU ENDL {printf("Answer: %d\n", $1);}
;

exp: INTNUM {$$ = $1; /*printf("Test: %d\n", $1);*/}
| exp PLUS exp {$$ = $1 + $3;}
| exp MINUS exp {$$ = $1 - $3;}
| exp MULT exp {$$ = $1 * $3;}
| exp DIV exp {
		if($3 == 0) {
			yyerror("Divide by 0");
			
		}
		else {
			$$ = $1 / $3;
		}
	}
| L_PAREN exp R_PAREN {$$ = $2;}

;

%%
/*Epilogue*/
