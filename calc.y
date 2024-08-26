%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);

%}

%union {
    int val;
}

%token <val> NUMBER
%token ADD SUB MUL DIV ABS OP CP EOL

%left ADD SUB
%left MUL DIV
%left ABS
%right UMINUS

%type <val> expr

%%

calculo:
    /* vacío */
    | calculo linea
    ;

linea:
    expr EOL    { printf("Resultado: %d\n", $1); }
    | EOL
    ;

expr:
    NUMBER          { $$ = $1; }
    | expr ADD expr { $$ = $1 + $3; }
    | expr SUB expr { $$ = $1 - $3; }
    | expr MUL expr { $$ = $1 * $3; }
    | expr DIV expr { $$ = $1 / $3; }
    | SUB expr %prec UMINUS { $$ = -$2; }
    | OP expr CP    { $$ = $2; }
    | ABS expr ABS  { $$ = abs($2); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Ingrese una expresión matemática:\n");
    return yyparse();
}

