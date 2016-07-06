%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "Parser.h"

%}

%option outfile="Lexer.c" header-file="Lexer.h"

%%

[ \t]	;
[0-9]+	{yylval.ival = atoi(yytext); return T_NUMBER; }
\n	{return T_NEWLINE;}
"+"	{return T_PLUS;}
"-"	{return T_MINUS;}
"*"	{return T_MULTIPLY;}
"/"	{return T_DIVIDE;}
"("	{return T_LEFT;}
")"	{return T_RIGHT;}
"quit"	{return T_QUIT;}

%%
