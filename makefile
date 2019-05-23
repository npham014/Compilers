all: parser clean
parser: mini_l.lex mini_l.y
	flex mini_l.lex
	bison -v -d --file-prefix=y mini_l.y
	gcc -o parser y.tab.c lex.yy.c -lfl
clean:
	rm -f lex.yy.c y.output y.tab.c y.tab.h
	echo Clean Done
