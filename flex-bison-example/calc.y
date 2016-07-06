%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "Lexer.h"

extern int yylex();
extern void yyerror(int * arg, const char * msg);

struct numval {
  int nodetype;
  int ival;
};

struct numval * make_numval(int nodetype, int val);
%}

%output "Parser.c"
%defines "Parser.h"

%parse-param {int * arg}
%union {
  int ival;
}

%token<ival> T_NUMBER
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_NEWLINE T_QUIT

%type<ival> expression

%start calculation

%%

calculation: 
	   | calculation line
;

line: T_NEWLINE
    | expression T_NEWLINE { printf("%d\n", $1); *arg = $1; return 1;} 
    | T_QUIT T_NEWLINE { printf("bye!\n"); exit(0); }
;

expression: T_NUMBER				{ *arg = $1; printf("expression: %d\n", $1); }
;

%%

main() {
        YY_BUFFER_STATE state;

        char buffer[] = "4\n2\nquit\n";

        state = yy_scan_bytes(buffer, strlen(buffer));

        struct numval * ret;

        int arg = 0;

	while(yyparse(&arg))
        {
          printf("Arg: %d\n", arg);
	}
}

void yyerror(int * arg, const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
