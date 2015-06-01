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
	var << "temp_" << tipo <<"_"<< i;
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

%start S

%token NUM
%left '-' '+'
%left '*' '/'
%precedence NEG   /* negation--unary minus */
%right '^'        /* exponentiation */

%%

S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador Nova Linguagem*/\n" << 
				"#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << $5.traducao << "\n\treturn 0;\n}" << endl; 
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

DECLARACAO	:TK_TIPO_INT TK_ID{

			$$.traducao = "\tDeclara =" + $2.label + "\n\tTipo: " + $1.label + "\n\t"+geraVariavel(i,$1.label);
			Tabela.push_back(node());
			Tabela[i].tipo = $1.label;
			Tabela[i].label = $2.label;
			Tabela[i].tempVar = geraVariavel(i,$1.label);
			i++;
			}
			|TK_TIPO_INT TK_ID TK_IGUAL TK_DECIMAL{

				$$.traducao = "\n\tDeclara =" + $2.label + "\n\tTipo: " + $1.label +  "\n\tValor: " + $4.traducao + "\n\t"+geraVariavel(i,$1.label);
				Tabela.push_back(node());
				Tabela[i].label = $2.label;
				Tabela[i].tipo = $1.label;
				Tabela[i].valor = $4.traducao;
				Tabela[i].tempVar = geraVariavel(i,$1.label);
				i++;
			}|TK_TIPO_FLOAT TK_ID{

				$$.traducao = "\n\tDeclara =" + $2.label + "\n\tTipo: " + $1.label + "\n\t"+geraVariavel(i,$1.label);
				Tabela.push_back(node());
				Tabela[i].label = $2.label;
				Tabela[i].tipo = $1.label;
				Tabela[i].tempVar = geraVariavel(i,$1.label);
				i++;
			}|TK_TIPO_FLOAT TK_ID TK_IGUAL TK_FLOAT{

				$$.traducao = "\n\tDeclara =" + $2.label + "\n\tTipo: " + $1.label + "\n\tValor: " + $4.traducao +"\n\t"+geraVariavel(i,$1.label);
				Tabela.push_back(node());
				Tabela[i].label = $2.label;
				Tabela[i].tipo = $1.label;
				Tabela[i].valor = $4.traducao;
				Tabela[i].tempVar = geraVariavel(i,$1.label);
				i++;
			
			}|TK_TIPO_STRING TK_ID{

				$$.traducao = "\n\tDeclara =" + $2.label + "\n\tTipo: " + $1.label + "\n\t"+geraVariavel(i,$1.label);
			
				Tabela.push_back(node());
				Tabela[i].label = $2.label;
				Tabela[i].tipo = $1.label;
				Tabela[i].tempVar = geraVariavel(i,$1.label);
				i++;
			}|TK_TIPO_STRING TK_ID TK_IGUAL TK_STRING{

				$$.traducao = "\n\tDeclara =" + $2.label + "\n\tTipo: " + $1.label +  "\n\tValor: " + $4.traducao + "\n\t"+geraVariavel(i,$1.label);
				Tabela.push_back(node());
				Tabela[i].label = $2.label;
				Tabela[i].tipo = $1.label;
				Tabela[i].valor = $4.traducao;
				Tabela[i].tempVar = geraVariavel(i,$1.label);
				i++;
			}|TK_TIPO_HEX TK_ID{

				$$.traducao = "\n\tDeclara =" + $2.label + "\n\tTipo: " + $1.label + "\n\t"+geraVariavel(i,$1.label);
			
				Tabela.push_back(node());
				Tabela[i].label = $2.label;
				Tabela[i].tipo = $1.label;
				Tabela[i].tempVar = geraVariavel(i,$1.label);
				i++;
			}|TK_TIPO_HEX TK_ID TK_IGUAL TK_HEX{

				$$.traducao = "\n\tDeclara =" + $2.label + "\n\tTipo: " + $1.label + "\n\tValor: " + $4.traducao +"\n\t"+geraVariavel(i,$1.label);
			
				Tabela.push_back(node());
				Tabela[i].label = $2.label;
				Tabela[i].tipo = $1.label;
				Tabela[i].valor = $4.traducao;
				Tabela[i].tempVar = geraVariavel(i,$1.label);
				i++;
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
			};


AUX: E{
	Tabela.push_back(node());
	Tabela[i].tempVar = geraVariavel2(i);
	//$$.traducao = "\n\t" + Tabela[i].tempVar + " = " +$1.traducao;
	i++;
	$$.traducao =  $1.traducao;
}

E	:	E '+' E { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			//if(Tabela[i-1].tipo.compare(Tabela[i-2].tipo) != 0){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[i].tempVar +  " = " + Tabela[i-1].tempVar + " + " + Tabela[i-2].tempVar +";";	
				i++;				
			//}
			//yyerror("Tipos diferentes");
					
		}
		| E '-' E        { $$.traducao = "\n\t" + $1.traducao + "-" + $3.traducao;      }
		| E '*' E        { $$.traducao = "\n\t" + $1.traducao + "*" + $3.traducao;      }
		| E '/' E        { $$.traducao = "\n\t" + $1.traducao + "/" + $3.traducao;      }
		| '(' E ')'        { $$ .traducao= $2.traducao ; }		
		| VALOR_OP   { $$.traducao=  $1.traducao; }
			;


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

			$$.traducao = "\n\t int " + Tabela[i].tempVar + " = " +  $1.traducao + ";";
			i++;
		}

		| TK_FLOAT { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "float";

			$$.traducao = "\n\t float " + Tabela[i].tempVar + " = " +  $1.traducao + ";";
			i++;
		 }
		| TK_HEX { 
			Tabela.push_back(node());
			Tabela[i].tempVar = geraVariavel2(i);
			Tabela[i].valor = $1.traducao;
			Tabela[i].tipo = "hex";

			$$.traducao = "\n\t hex " + Tabela[i].tempVar + " = " +  $1.traducao + ";";
			i++;
		 }
		| TK_STRING {$$.traducao = $1.traducao;};
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
