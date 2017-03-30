{%
#include <stdio.h>
void yyerror(const char *msg);
}%

%token

%%
.               yyerror();
%%

void yyerror(const char *msg){
  printf("Error en [%s] \n", msg);
}
