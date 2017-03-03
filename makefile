miniC: lex.yy.c lexico2.c lexico1.h
	gcc lexico2.c -w lex.yy.c -lfl -o miniC

lex.yy.c: lexico1.l
	flex lexico1.l
	
clean:
	rm lex.yy.c miniC
