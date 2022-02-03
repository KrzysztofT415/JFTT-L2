%{
    int doxygen_enabled; //DOXYGEN COMMENTS: /**, /*!, /// i //!
%}

%s doxygen
%%
    if (doxygen_enabled) { BEGIN(doxygen); } else { BEGIN(INITIAL); }

['"<]([^'">])*['">] { fprintf(yyout, "%s", yytext); } // inside brackets
<doxygen>\n?[ ]*\/\/![^\n]*\n { fprintf(yyout, "%s", yytext); } //!
<doxygen>\n?[ ]*\/\/\/[^\n]*\n { fprintf(yyout, "%s", yytext); } ///
<doxygen>\n?[ ]*\/\*!([^\*]|\*[^\/])*\*\/ { fprintf(yyout, "%s", yytext); } /*! */
<doxygen>\n?[ ]*\/\*\*([^\*]|\*[^\/])*\*\/ { fprintf(yyout, "%s", yytext); } /** */
\n?[ ]*\/\*([^\*]|\*[^\/])*\*\/ {} /* */
\n?[ ]*\/\/[^\n]*\n {} //
%%

int yywrap(void) { return 1; }

int main(void) {
    if (getchar() == 'd') doxygen_enabled = 1;

    extern FILE *yyin, *yyout;

    yyin = fopen("test", "r");
    yyout = fopen("test_out", "w");

    yylex();

    return 0;
}