%{
#include <iostream>
#include <string>
#include <sstream>
#include <stdio.h>
#include <vector>
#include <algorithm>
#include <math.h>

#define YYSTYPE atributos

using namespace std;

struct atributos {
	string label;
	string traducao;
};

struct node {
	string label;
	string tipo;
	string tempVar;
	string valor;
};

int i = 0;
string teste;

string geraVariavel(int i, string tipo){
	stringstream var;
	var << tipo << " temp_" << i;
	return var.str();
}

string geraVariavel2(int i){
	stringstream var;
	var << "temp_" << i;
	return var.str();
}

int yylex(void);
void yyerror(string);
vector<node> Tabela;

%}

%token TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_STRING TK_TIPO_HEX
%token TK_MAIN TK_ERRO TK_ID TK_IGUAL
%token TK_DECIMAL TK_N_DECIMAL TK_FLOAT TK_HEX TK_STRING //Valores
%token TK_MAIOR_IGUAL TK_IGUAL_IGUAL TK_MENOR_IGUAL TK_DIFERENTE
%token TK_TRUE TK_FALSE

%start S

%token NUM 
%left TK_AND TK_OR
%left '-' '+'
%left '*' '/'
%precedence NEG   /* negation--unary minus */
%right '^'        /* exponentiation */
%nonassoc TK_IGUAL 

%%

S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador Nova Linguagem*/\n" << 
				"#include <iostream>\n#include<string.h>\n#include<stdio.h>\n#define true 1; \n#define false 0; \nint main(void)\n{\n" << $5.traducao << "\n\treturn 0;\n}" << endl; 
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO ';'COMANDOS{
				$$.traducao = $1.traducao + $3.traducao;
			}
			|{$$.traducao = "";}
			;

COMANDO 	: AUX
		|DECLARACAO
		|ATRIBUICAO
		;

TK_TIPO: TK_TIPO_INT
		 |TK_TIPO_FLOAT
		 |TK_TIPO_HEX
		 |TK_TIPO_STRING
		;

DECLARACAO	:TK_TIPO TK_ID{

			$$.traducao =  "\n\t" + $1.label + " " + $2.label + ";";
			Tabela.push_back(node());
			Tabela[i].tipo = $1.label;
			Tabela[i].label = $2.label;
			Tabela[i].tempVar = geraVariavel(i,$1.label);
			i++;
			}
			|TK_TIPO TK_ID TK_IGUAL E {
				$$.traducao =  $4.traducao;				
			}			
			;
			
ATRIBUICAO :TK_ID TK_IGUAL VALOR{						
				for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.
				   node temp = Tabela.at(i);
				   if (temp.label.compare($3.traducao) != 0){				   
				   		Tabela.at(i).valor = $3.traducao;
				   		//teste = Tabela.at(i).valor; --> linha utilizada para verificar se estava funcionando;
				   		//Faz a atribuição a variavel depois que ela foi declarada. Ex: var = 2;
				   }
				}			
				$$.traducao =  "\n\t" + $1.label + $2.label + $3.traducao + ";";
			}
			;

AUX: E{
	Tabela.push_back(node());
	Tabela[i].tempVar = geraVariavel2(i);	
	i++;
	$$.traducao =  "\t"+$1.traducao;
}

E	:	E '+' E { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor =  Tabela[i-1].valor + " + " + Tabela[i-2].valor;

			if(Tabela[i-1].tipo.compare(Tabela[i-2].tipo) == 0){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[i-1].tipo + " " + Tabela[i].tempVar +  " = " + Tabela[i-1].tempVar + " + " + Tabela[i-2].tempVar +";";	
				Tabela[i].tipo = Tabela[i-1].tipo;
			}
			else if( (Tabela[i-1].tipo.compare("float") == 0) && (Tabela[i-2].tipo.compare("int") == 0) || (Tabela[i-1].tipo.compare("int") == 0) && (Tabela[i-2].tipo.compare("float") == 0) ){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + "float " + Tabela[i].tempVar +  " = " + "(float)" + Tabela[i-1].tempVar + " + " + "(float)" + Tabela[i-2].tempVar +";";
				Tabela[i].tipo = "float";
			}
			else{
				yyerror("Tipos diferentes");
			}	
			i++;	
		}
		| E '-' E        { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor =  Tabela[i-1].valor + " - " + Tabela[i-2].valor;
			
			if(Tabela[i-1].tipo.compare(Tabela[i-2].tipo) == 0){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[i-1].tipo + " " + Tabela[i].tempVar +  " = " + Tabela[i-1].tempVar + " - " + Tabela[i-2].tempVar +";";	
				Tabela[i].tipo = Tabela[i-1].tipo;
			}
			else if( (Tabela[i-1].tipo.compare("float") == 0) && (Tabela[i-2].tipo.compare("int") == 0) || (Tabela[i-1].tipo.compare("int") == 0) && (Tabela[i-2].tipo.compare("float") == 0) ){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + "float " + Tabela[i].tempVar +  " = " + "(float)" + Tabela[i-1].tempVar + " - " + "(float)" + Tabela[i-2].tempVar +";";
				Tabela[i].tipo = "float";
			}
			else{
				yyerror("Tipos diferentes");
			}	
			i++;
		}
		| E '*' E        { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor =  Tabela[i-1].valor + " * " + Tabela[i-2].valor;

			if(Tabela[i-1].tipo.compare(Tabela[i-2].tipo) == 0){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[i-1].tipo + " " + Tabela[i].tempVar +  " = " + Tabela[i-1].tempVar + " * " + Tabela[i-2].tempVar +";";	
				Tabela[i].tipo = Tabela[i-1].tipo;
			}
			else if( (Tabela[i-1].tipo.compare("float") == 0) && (Tabela[i-2].tipo.compare("int") == 0) || (Tabela[i-1].tipo.compare("int") == 0) && (Tabela[i-2].tipo.compare("float") == 0) ){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + "float " + Tabela[i].tempVar +  " = " + "(float)" + Tabela[i-1].tempVar + " * " + "(float)" + Tabela[i-2].tempVar +";";
				Tabela[i].tipo = "float";
			}
			else{
				yyerror("Tipos diferentes");
			}	
			i++;	
		}
		| E '/' E        { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor =  Tabela[i-1].valor + " / " + Tabela[i-2].valor;

			if(Tabela[i-1].tipo.compare(Tabela[i-2].tipo) == 0){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[i-1].tipo + " " + Tabela[i].tempVar +  " = " + Tabela[i-1].tempVar + " / " + Tabela[i-2].tempVar +";";	
				Tabela[i].tipo = Tabela[i-1].tipo;
			}
			else if( (Tabela[i-1].tipo.compare("float") == 0) && (Tabela[i-2].tipo.compare("int") == 0) || (Tabela[i-1].tipo.compare("int") == 0) && (Tabela[i-2].tipo.compare("float") == 0) ){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + "float " + Tabela[i].tempVar +  " = " + "(float)" + Tabela[i-1].tempVar + " / " + "(float)" + Tabela[i-2].tempVar +";";
				Tabela[i].tipo = "float";
			}
			else{
				yyerror("Tipos diferentes");
			}	
			i++;	
		}
		| '(' E ')'        { $$ .traducao= $2.traducao ; 
		}|E TK_MAIOR_IGUAL E 		{
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].tipo = "boolean";
			if(Tabela[i-2].valor >= Tabela[i-1].valor){
				Tabela[i].valor = "true";
			}else{Tabela[i].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[i].tempVar + " = " + Tabela[i-2].tempVar + " >= " + Tabela[i-1].tempVar +";\n";
			i++;
		}| E '>' E 		{
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].tipo = "boolean";
			if(Tabela[i-2].valor > Tabela[i-1].valor){
				Tabela[i].valor = "true";
			}else{Tabela[i].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[i].tempVar + " = " + Tabela[i-2].tempVar + " > " + Tabela[i-1].tempVar +";\n";
			i++;
		}|E TK_MENOR_IGUAL E 		{
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].tipo = "boolean";
			if(Tabela[i-2].valor <= Tabela[i-1].valor){
				Tabela[i].valor = "true";
			}else{Tabela[i].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[i].tempVar + " = " + Tabela[i-2].tempVar  + " <= " + Tabela[i-1].tempVar + ";\n";
			i++;
		}|E '<' E 		{
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].tipo = "boolean";
			if(Tabela[i-2].valor < Tabela[i-1].valor){
				Tabela[i].valor = "true";
			}else{Tabela[i].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[i].tempVar + " = " + Tabela[i-2].tempVar  + " < " + Tabela[i-1].tempVar + ";\n";
			i++;
		}|E TK_DIFERENTE E 		{
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].tipo = "boolean";
			if(Tabela[i-2].valor != Tabela[i-1].valor){
				Tabela[i].valor = "true";
			}else{Tabela[i].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[i].tempVar + " = " + Tabela[i-2].tempVar  + " != " + Tabela[i-1].tempVar + ";\n";
			i++;
		}	
		|E TK_AND E {
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor =  Tabela[i-1].valor + " && " + Tabela[i-2].valor;

			if(Tabela[i-1].tipo.compare(Tabela[i-2].tipo) == 0){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[i-1].tipo + " " + Tabela[i].tempVar +  " = " + Tabela[i-1].tempVar + " && " + Tabela[i-2].tempVar +";";	
				Tabela[i].tipo = Tabela[i-1].tipo;
			}			
			else{
				yyerror("Tipos diferentes");
			}	
			i++;
		}	
		|E TK_OR E {
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor =  Tabela[i-1].valor + " || " + Tabela[i-2].valor;
			
			$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[i-1].tipo + " " + Tabela[i].tempVar +  " = " + Tabela[i-1].tempVar + " || " + Tabela[i-2].tempVar +";";	
			Tabela[i].tipo = Tabela[i-1].tipo;
			
			i++;
		}	
		| VALOR_OP   { $$.traducao=  $1.traducao; }
		| BOOLEAN 
		;

BOOLEAN: TK_TRUE { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "bool";


			$$.traducao =  "\n\tbool " + Tabela[i].tempVar + " = " + $1.label + ";";
			i++;
		}
		 |TK_FALSE{ 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "bool";


			$$.traducao =  "\n\tbool " + Tabela[i].tempVar + " = " + $1.label + ";";
			i++;
		}

// Recebe todos os valores
VALOR:  TK_DECIMAL { $$.traducao=$1.traducao; }
		| TK_FLOAT { $$.traducao=$1.traducao; }
		| TK_HEX { $$.traducao= $1.traducao; }
		| TK_STRING {$$.traducao = $1.traducao;};


// Recebe todos os valores
VALOR_OP:  TK_DECIMAL { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "int";

			$$.traducao = "\n\tint " + Tabela[i].tempVar + " = " +  $1.traducao + ";";
			i++;
		}

		| TK_FLOAT { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "float";

			$$.traducao = "\n\tfloat " + Tabela[i].tempVar + " = " +  $1.traducao + ";";
			i++;
		 }
		| TK_HEX { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "hex";

			$$.traducao = "\n\thex " + Tabela[i].tempVar + " = " +  $1.traducao + ";";
			i++;
		 }
		| TK_STRING {
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "string";

			$$.traducao = "\n\tstring " + Tabela[i].tempVar + " = " +  $1.traducao + ";";
			i++;
		};
%%


#include "lex.yy.c"


int yyparse();

int main( int argc, char* argv[] )
{
	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				
