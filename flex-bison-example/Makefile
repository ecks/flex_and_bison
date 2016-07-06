all: calc

Parser.c Parser.h: calc.y
	bison -d calc.y

Lexer.c: calc.l Parser.h
	flex calc.l

calc: Lexer.c Parser.c Parser.h
	gcc -o calc Parser.c Lexer.c -lfl

clean:
	rm calc Parser.c Lexer.c Parser.h Lexer.h
