/* fb2-2.l : 여러 파일을 처리하는 Flex word count */
%option noyywrap

%{
#include <stdio.h>
#include <string.h>

int chars = 0;
int words = 0;
int lines = 0;
int totchars = 0;
int totwords = 0;
int totlines = 0;

extern FILE *yyin;
%}

%%
[a-zA-Z]+      { words++; chars += strlen(yytext); }
\n             { chars++; lines++; }
.              { chars++; }
%%

int main(int argc, char **argv)
{
    int i;
    if (argc < 2) {  // 표준 입력에서 읽기
        yylex();
        printf("%8d%8d%8d\n", lines, words, chars);
        return 0;
    }

    for (i = 1; i < argc; i++) {
        FILE *f = fopen(argv[i], "r");
        if (!f) {
            perror(argv[i]);
            return 1;
        }

        yyrestart(f);     // 이 파일로 스캐너 초기화
        yylex();
        fclose(f);

        printf("%8d%8d%8d %s\n", lines, words, chars, argv[i]);

        totchars += chars; chars = 0;
        totwords += words; words = 0;
        totlines += lines; lines = 0;
    }

    if (argc > 2) {  // 총합 출력
        printf("%8d%8d%8d total\n", totlines, totwords, totchars);
    }

    return 0;
}
