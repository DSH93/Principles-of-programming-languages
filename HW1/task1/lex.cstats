%{
#include <stdio.h>
#include <stdlib.h>

int keyword_count = 0, symbol_count = 0,
identifiers_count = 0, decimal_count = 0,
octal_count = 0, string_count = 0,
integers_count = 0, comments_count = 0,
multi_line_count = 0, single_line_count = 0,
total_length = 0;

FILE *yyin;
%}

%%

"/*"([^*]|\*+[^*/])*\*+"/"                          { comments_count++; multi_line_count++; }
"/*"([^*]|\*+[^*/])*                                { fprintf(stderr,"Error: unterminated multi-line comment\n"); exit(-1); }
"//".*                                              { comments_count++; single_line_count++; }
"int"|"while"|"for"|"if"|"else"|"void"|"return"     { keyword_count++; }
[a-zA-Z_][a-zA-Z0-9_]*                              { identifiers_count++; }
[\{\}\(\)\[\];,]|[=+<>*]|"!="|"=="                  { symbol_count++; }
0|[1-9][0-9]*                                       { decimal_count++; integers_count++; }
0[0-7]+                                             { octal_count++; integers_count++;}
0[89][0-9]*|0[8-9]                                  { fprintf(stderr,"Error: invalid octal number %s\n", yytext); exit(-1);}
\"([^\"\\]|\\.)*\"                                  { string_count++; const char* text = yytext; while(*text){total_length++; text++;} total_length = total_length - 3;}
\"([^\"\\]|\\.)*$                                   { fprintf(stderr,"Error: unterminated string: %s\n", yytext); exit(-1);}
\n                                                  ; 
[ \t\r]+                                            { /* Ignore whitespace */ }
.                                                   {fprintf(stderr,"Error: invalid character %s\n", yytext); exit(-1);}


%%

int main(int argc, char **argv) {
    if (argc == 1) {
        printf("No file provided. Waiting for input from stdin (press Ctrl+D to end):\n");
        yyin = stdin; 
    } else {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening file");
            exit(EXIT_FAILURE);
        }
    }

    yylex(); 

    if (yyin != stdin) {
        fclose(yyin); 
    }

    
    printf("%d keywords, %d identifiers, %d symbols\n", keyword_count, identifiers_count, symbol_count);
    printf("%d integers (%d decimal, %d octal)\n", integers_count, decimal_count, octal_count);
    printf("%d comments (%d multi-line, %d single-line)\n", comments_count, multi_line_count, single_line_count);
    printf("%d strings (total length is %d)\n", string_count, total_length);



    return 0;
}
