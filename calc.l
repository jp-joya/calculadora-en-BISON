%{
# include "calc.tab.h"
%}
%%
[0-9]+  { yylval.val = atoi(yytext);; return NUMBER; }
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"     { return ABS; }
"("     { return OP; }
")"     { return CP; }
\n      { return EOL; }
"//".*  
[ \t]   { /* ignore espacio en blanco */ }
.	{ printf("Caracter no encontrado. %c\n", *yytext); }
%%
int yywrap(){return 1;}
