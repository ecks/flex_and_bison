all: json

json_parser.c: json_parser.y
	bison --report=state -d json_parser.y

json_lexer.c: json_lexer.l
	flex json_lexer.l

json: json_lexer.c json_parser.c json_parser.h
	gcc -o json json_parser.c json_lexer.c -lfl

clean:
	rm json json_parser.c json_lexer.c json_parser.h json_lexer.h
