%{
#include <stdio.h>

int yywrap(void) {
    return 1;
}
%}

%%

"colour"        { printf("color"); }
"flavour"       { printf("flavor"); }
"clever"        { printf("smart"); }
"smart"         { printf("elegant"); }
"conservative"  { printf("liberal"); }

.               { printf("%s", yytext); }

%%