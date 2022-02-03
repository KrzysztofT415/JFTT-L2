%{
#include<math.h>
#define stack_size 100
#define error_buff_size 100
static char ERROR[error_buff_size];
static int top = -1;
static int stack[stack_size];
static void clear(void) {  }
static void push(int i) {
    if (++top < stack_size) stack[top]= i;
    else sprintf(ERROR, "err: Stack Overflow\n");
}
static int pop(void) {
    if (top >= 0) return stack[top--];
    else sprintf(ERROR, "err: Less numbers than expected\n");
}
static int myPow(int a, int b) {
    return pow(a, b);
}
int int_value;
%}

%%
q { return 0; }
-?[0-9]+ { push(atoi(yytext));}
\+ { push(pop() + pop()); }
\* { push(pop() * pop()); }
\- { int rhs = pop(); push(pop() - rhs); }
\/ {
    int rhs = pop();
    if (rhs == 0) { sprintf(ERROR, "err: Dividing by 0\n"); }
    else push(pop() / rhs);
    }
\% {
    int rhs = pop();
    if (rhs == 0) { sprintf(ERROR, "err: Dividing by 0\n"); }
    else push(pop() % rhs);
    }
\^ { int rhs = pop(); push(myPow(pop(), rhs)); }
[ \t] {}
\n {
    if (*ERROR != '\0') puts(ERROR); 
    else if (top == -1) puts("err: Empty input\n");
    else if (top > 0) puts("err: Too many numbers\n");
    else printf("= %d\n", pop());
    
    top = -1;
    *ERROR = '\0';
}
. { sprintf(ERROR, "err: Invalid character - %s\n", yytext); } 
%%

int yywrap(void) { return 1; }

#include<math.h>
int main(void) {
    yylex();
    return 0;
}