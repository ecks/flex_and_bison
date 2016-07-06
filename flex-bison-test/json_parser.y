%{

#include <stdint.h>

#include "json_lexer.h"

extern int yylex();
extern void yyerror(const char * s); 

%}

%output "json_parser.c"
%defines "json_parser.h"

%union {
  int ival;
}

%token<ival> T_NUMBER
%token T_OPEN_BRACE T_CLOSE_BRACE T_COMMA T_OPEN_BRACKET T_CLOSE_BRACKET
%token T_HEADER T_ROUTER_ID T_AREA_ID T_VERSION T_TYPE T_LENGTH T_CHECKSUM T_INSTANCE_ID T_RESERVED
%token T_MSG
%token T_OPTIONS
%token T_ROUTER_IDS
%right T_VERSION

%type<ival> header_expression msg_expression

%start line_test

%%

statement: T_OPEN_BRACE body T_CLOSE_BRACE
;

line_test: statement
;

body: T_HEADER statement T_COMMA T_MSG statement
    | inner
;

inner: header
     | msg
;

header: header_expression T_COMMA header_expression T_COMMA header_expression
;

msg: msg_expression
;

header_expression: T_VERSION T_NUMBER { printf("returned %d\n", $2); $$ = $2; }
                 | T_TYPE    T_NUMBER { printf("returned %d\n", $2); $$ = $2; }
                 | T_OPTIONS T_NUMBER { printf("returned %d\n", $2); $$ = $2; }
;

msg_expression: T_OPTIONS T_NUMBER { printf("returned %d\n", $2); $$ = $2; }
;
%%

void main()
{
  char buffer[] = "{header: {version: 2, type: 4, options: 2}, msg: {options: 5}}";

  YY_BUFFER_STATE bs = yy_scan_bytes(buffer, strlen(buffer));
  yy_switch_to_buffer(bs);

  if(yyparse())
  {
    printf("Error\n");
  }

  yy_delete_buffer(bs);
}

void yyerror(const char * s)
{
  fprintf(stderr, "Parse error: %s\n", s);
}
