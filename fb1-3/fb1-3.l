%{
#include <stdio.h>
%}

%%
"+"    { printf("PLUS\n"); }
"-"    { printf("MINUS\n"); }
"*"    { printf("TIMES\n"); }
"/"    { printf("DIVIDE\n"); }
"|"    { printf("ABS\n"); }
[0-9]+ { printf("NUMBER %s\n", yytext); }
\n     { printf("NEWLINE\n"); }
[ \t]  { } // 공백 무시
.      { printf("Mystery character %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}

