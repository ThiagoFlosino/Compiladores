all: 	
		clear
		lex ./Lex/nova_linguagem.l
		yacc -d ./Sintatica/sintatica.y
		g++ -o glf y.tab.c -lfl

		./glf < teste.nova
