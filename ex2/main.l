%{

%}

%%
['"]([^'"])*['"] { fprintf(yyout, "%s", yytext); } // inside brackets
\<!\[CDATA\[([^\]]|\][^\]]|\]\][^>])*\]\]> { fprintf(yyout, "%s", yytext); } // inside CDATA
\n?[ ]*(<!--([^-]|-[^-])*-->) {} // normal comments
%%

int yywrap(void) { return 1; }

int main(void) {
    extern FILE *yyin, *yyout;

    yyin = fopen("test", "r");
    yyout = fopen("test_out", "w");

    yylex();

    return 0;
}