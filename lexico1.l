%{
#include "lexico1.h"
long long auxiliar;
%}
digito [0-9]
letra  [a-zA-Z]
entero {digito}+
float  {entero}+[.]{entero}+
panico [^/ \n\t():,;+\-*/a-zA-Z0-9"]
boollit ("true"|"false")
%x COM
%x CAD
%option yylineno
%%
[ \t]+                        ;
[\n]+                         ;
"//"(.*)[\n]                  ;
float                         return FLOAT;
int                           return INT;
bool                          return BOOL;
func                          return FUNC;
print                         return PRINT;
var                           return VAR;
let                           return LET;
if                            return IF;
else                          return ELSE;
while                         return WHILE;
read                          return READ;
[Aa][Nn][Dd]                  return AND;
[Oo][Rr]                      return OR;
[Nn][Oo][Tt]                  return NOT;
[Mm][Oo][Dd]                  return MOD;
{boollit}		              return BOOLLIT;
{letra}({letra}|{digito}|_)*  {comprobarID(); return ID;}
{entero}                      {comprobarINT(); return INTLITERAL;} 
{float}                       return FLOATLITERAL;
"("                           return LPAREN;
")"                           return RPAREN;
"{"                           return LCORCH;
"}"                           return RCORCH;
";"                           return SEMICOLON;
","                           return COMMA;
"=="                          return EQUAL;
">="                          return MAEQU;
"<="                          return MIEQU;
">"                           return SUP;
"<"                           return INF;
"!="                          return NOTEQU;
"||"                          return OROP;
"&&"                          return ANDOP;
"="                           return ASSIGNOP;
"+"                           return PLUSOP;
"-"                           return MINUSOP;
"*"                           return MULT;
"/"                           return DIVI;
{panico}+                     error_lexico();

"/*"                          BEGIN(COM);
<COM>[^*/]+                   ;
<COM>"*"+[^*/]+               ;
<COM>"*"+"/"                  BEGIN(0);
<COM><<EOF>>                  {printf("Comentario sin cerrar. \n"); yyterminate();}

\"                         {BEGIN(CAD); yymore();}
<CAD>[^"\\\n]*             yymore();
<CAD>(\\[ntr"\\])*         yymore();
<CAD>\"                    {BEGIN(0);  return CADENA;}
<CAD><<EOF>>               {printf("Cadena sin cerrar. \n"); yyterminate();}

%%

comprobarID(){
	if(yyleng > 16) printf("Warning: Identificador %s demasiado largo \n",yytext);
}

comprobarINT(){
	auxiliar = atoll(yytext);
	if(auxiliar > 2147483648LL) printf("Warning: Entero %s demasiado largo \n",yytext);
}

error_lexico(){
  	printf("\nERROR en la linea %d, simbolo '%s' no reconocido \n",yylineno,yytext);
}
