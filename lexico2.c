#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "lexico1.h"

extern char *yytext;
extern int  yyleng;
extern FILE *yyin;
FILE *fich;

main() 
{
	int i;
	char nombre[80];
	printf("INTRODUCE NOMBRE DE FICHERO FUENTE: ");
	fgets(nombre,80,stdin);
	nombre[strlen(nombre)-1] = '\0'; 
	printf("\n");
	if ((fich=fopen(nombre,"r"))==NULL) {
		printf("***ERROR, no puedo abrir el fichero\n");
		exit(1);
	}
	yyin = fich;
	while (i = yylex()) {
		printf("TOKEN %d",i);
		if (i==ID) printf(" LEXEMA %s LONGITUD %d\n",yytext,yyleng);
		else printf("\n");
	}
	fclose(fich);
	return 0;

	
}	
