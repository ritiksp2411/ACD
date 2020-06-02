/*
Written lexer to send token stream to the parser from the test code.
*/

%{
	#include <stdio.h> 
	#include <stdlib.h> 
	#include "y.tab.h" 
	extern int yycolumn;
	extern int yyleng;
%}


SPACE			[ \t\v\f]
IDEN	 		[a-zA-Z_]([a-zA-Z0-9_])*
NO				([0-9]+|[0-9]+\.[0-9]+)
OPER			[-+*/]|"=="|">="|"<="|">"|"<"
UN_OPER			"++"|"--"	
SINGLE_CHAR		[=(){};]

%%

\n 				{ yycolumn = 0; yylineno++; }
{NO}			{ yycolumn += yyleng; return NUM; }
{UN_OPER}		{ yycolumn += yyleng; return U_OP; }
{OPER}			{ yycolumn += yyleng; return OP; }
{SPACE}		    { yycolumn += yyleng; }
"if"            { yycolumn += 2; return IF; }
"for"           { yycolumn += 3; return FOR; }
"else"          { yycolumn += 4; return ELSE; }
{IDEN}			{ yycolumn += yyleng; return IDEN; }
{SINGLE_CHAR}   { yycolumn++; return yytext[0]; }
.				{ yycolumn += 1; return yytext[0];}

%%
  
int yywrap() {  
	return -1;  
}