%{
    int words = 0, lines = 0;
%}

%%
^[ \t]*\n? {} // beggining
[ \t]+\n { fprintf(yyout, "\n"); lines++; words++; } // end of line
[ \t]+ { fprintf(yyout, " "); words++; } // in between
\n { fprintf(yyout, "%s", yytext); lines++; words++; } // just new line
%%

int yywrap(void) { return 1; }

int main(void) {
    extern FILE *yyin, *yyout;

    yyin = fopen("test", "r");
    yyout = fopen("test_out", "w");

    yylex();
    fprintf(yyout, "words: %d; lines: %d", words, lines);

    return 0;
}