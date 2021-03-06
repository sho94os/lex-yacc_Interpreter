%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"



%}



Letter [a-zA-Z]
Digit [0-9]

%%

"quit"			{exit(EXIT_SUCCESS);}

"#".*\n 		{ yylineno = yylineno + 1; }

"mainprog"		;
"var" 			{return VAR;}
"array"			{return ARRAY;}
"of"			{return OF;}
"function"		;
"procedure"		;
"begin"			;
"end"			;
"if"			;
"then"			;
"else"			;
"nop"			;
"while"			;
"return"		;
"print"			{return PRINT;}


"int" 			{return INT;}
"float" 		{return FLOAT;}
"/t"			{// printf("%s\n", yytext);
			 return SYMTAB;}



{Letter}({Letter}|{Digit})*	{yylval.str = strdup(yytext);
				//printf("%s\n", yylval.str);
				return Identifier	;}

{Digit}+			{yylval.inum = atoi(yytext); return Integer;}

{Digit}+\.{Digit}+		{yylval.fnum = atof(yytext); return Float;}


"+"			{yylval.c = yytext[0]; return PLUS;}
"-"			{yylval.c = yytext[0]; return MINUS;}
"*"			{yylval.c = yytext[0]; return MULTIPLY;}
"/" 			{yylval.c = yytext[0]; return DIVIDE;}


"<"			;
">"			;
"!"			;
"<="			;
">="			;
"=="			;
"!="			;			


"."			{yylval.c = yytext[0]; return DOT;}
","			;
"="			{yylval.c = yytext[0]; return ASSIGN_SIGN;}
":"			{yylval.c = yytext[0]; return DECLARE_SIGN;}
";"			;

"("			;
")"			;
"["			{yylval.c = yytext[0]; return L_BRACKET;}
"]"			{yylval.c = yytext[0]; return R_BRACKET;}

[\n]			{ yylineno = yylineno + 1; }				
[ \t]			;
.			;

%%

int yywrap(void) { 
    return 1;
}
