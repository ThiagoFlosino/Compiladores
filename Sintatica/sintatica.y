%{
#include <iostream>
#include <string.h>
#include <sstream>
#include <stdio.h>
#include <vector>
#include <algorithm>
#include <math.h>
#include <map>

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
	string conteudo;
};
int contVar = 0;
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
map<string, string> TabelaTipos;

void criaTabelaTipos(){	

	 //Tabela de Operação para soma
    TabelaTipos["int+int"] = "int";
    TabelaTipos["int+float"] = "float";
    TabelaTipos["int+string"] = "string";
    TabelaTipos["int+char"] = "char"; //Verificar se será esse tipo mesmo para essa operação
    TabelaTipos["int+hex"] = "hex";
    TabelaTipos["float+int"] = "float";
    TabelaTipos["float+float"] = "float";
    TabelaTipos["float+string"] = "string";
    TabelaTipos["float+char"] = "ERRO";
    TabelaTipos["float+hex"] = "ERRO";
    TabelaTipos["string+int"] = "ERRO";
    TabelaTipos["string+float"] = "string";
    TabelaTipos["string+string"] = "string";
    TabelaTipos["string+char"] = "string";
    TabelaTipos["string+hex"] = "string";
    TabelaTipos["char+int"] = "char";
    TabelaTipos["char+float"] = "ERRO";
    TabelaTipos["char+string"] = "string";
    TabelaTipos["char+char"] = "string";
    TabelaTipos["char+hex"] = "hex";
    TabelaTipos["hex+int"] = "hex";
    TabelaTipos["hex+float"] = "ERRO";
    TabelaTipos["hex+string"] = "string";
    TabelaTipos["hex+char"] = "hex";
    TabelaTipos["hex+hex"] = "hex";

    //Tabela de Operação para subtração    
    TabelaTipos["int-int"] = "int";
    TabelaTipos["int-float"] = "float";
    TabelaTipos["int-string"] = "string";
    TabelaTipos["int-char"] = "char"; //Verificar se será esse tipo mesmo para essa operação
    TabelaTipos["int-hex"] = "hex";
    TabelaTipos["float-int"] = "float";
    TabelaTipos["float-float"] = "float";
    TabelaTipos["float-string"] = "string";
	TabelaTipos["float-char"] = "ERRO";
    TabelaTipos["float-hex"] = "ERRO";
    TabelaTipos["string-int"] = "ERRO";
    TabelaTipos["string-float"] = "string";
    TabelaTipos["string-string"] = "string";
    TabelaTipos["string-char"] = "string";
    TabelaTipos["string-hex"] = "string";
    TabelaTipos["char-int"] = "char";
    TabelaTipos["char-float"] = "ERRO";
    TabelaTipos["char-string"] = "string";
    TabelaTipos["char-char"] = "string";
    TabelaTipos["char-hex"] = "hex";
    TabelaTipos["hex-int"] = "hex";
    TabelaTipos["hex-float"] = "ERRO";
    TabelaTipos["hex-string"] = "string";
    TabelaTipos["hex-char"] = "hex";
    TabelaTipos["hex-hex"] = "hex";

    //Tabela de Operação para multiplicação
    TabelaTipos["int*int"] = "int";
    TabelaTipos["int*float"] = "float";
    TabelaTipos["int*string"] = "ERRO";
    TabelaTipos["int*char"] = "string"; //Verificar se será esse tipo mesmo para essa operação
	TabelaTipos["int*hex"] = "ERRO";

    TabelaTipos["float*int"] = "float";
    TabelaTipos["float*float"] = "float";
    TabelaTipos["float*string"] = "ERRO";
    TabelaTipos["float*char"] = "ERRO";
    TabelaTipos["float*hex"] = "ERRO";

    TabelaTipos["string*int"] = "string"; //Alterar isso depois para poder repetir a string n vezes
    TabelaTipos["string*float"] = "ERRO";
    TabelaTipos["string*string"] = "ERRO";
    TabelaTipos["string*char"] = "ERRO";
    TabelaTipos["string*hex"] = "ERRO";

    TabelaTipos["char*int"] = "string"; 
    TabelaTipos["char*float"] = "ERRO";
    TabelaTipos["char*string"] = "ERRO";
    TabelaTipos["char*char"] = "ERRO";
    TabelaTipos["char*hex"] = "ERRO";

    TabelaTipos["hex*int"] = "ERRO";
    TabelaTipos["hex*float"] = "ERRO";
    TabelaTipos["hex*string"] = "ERRO";
    TabelaTipos["hex*char"] = "ERRO";
    TabelaTipos["hex*hex"] = "hex";

    //Tabela de Operação para divisão
    TabelaTipos["int/int"] = "int";
    TabelaTipos["int/float"] = "float";
    TabelaTipos["int/string"] = "ERRO";
    TabelaTipos["int/char"] = "ERRO"; //Verificar se será esse tipo mesmo para essa operação
    TabelaTipos["int/hex"] = "ERRO";

    TabelaTipos["float/int"] = "float";
    TabelaTipos["float/float"] = "float";
    TabelaTipos["float/string"] = "ERRO";
    TabelaTipos["float/char"] = "ERRO";
    TabelaTipos["float/hex"] = "ERRO";

    TabelaTipos["string/int"] = "ERRO";
    TabelaTipos["string/float"] = "ERRO";
    TabelaTipos["string/string"] = "ERRO";
    TabelaTipos["string/char"] = "ERRO";
    TabelaTipos["string/hex"] = "ERRO";

    TabelaTipos["char/int"] = "ERRO";
    TabelaTipos["char/float"] = "ERRO";
    TabelaTipos["char/string"] = "ERRO";
    TabelaTipos["char/char"] = "ERRO";
    TabelaTipos["char/hex"] = "ERRO";

    TabelaTipos["hex/int"] = "ERRO";
    TabelaTipos["hex/float"] = "ERRO";
    TabelaTipos["hex/string"] = "ERRO";
    TabelaTipos["hex/char"] = "ERRO";
    TabelaTipos["hex/hex"] = "ERRO";
}

string verificaTipo(string tipoA, string operador, string tipoB){
	if(TabelaTipos.empty()){
		criaTabelaTipos();
	}
	string busca = tipoA+operador+tipoB;
	string retorno  =TabelaTipos.find(busca)->second;
	return retorno;
}



%}
%token TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_STRING TK_TIPO_HEX
%token TK_MAIN TK_ERRO TK_ID TK_IGUAL
%token TK_DECIMAL TK_N_DECIMAL TK_FLOAT TK_HEX TK_STRING //Valores
%token TK_MAIOR_IGUAL TK_IGUAL_IGUAL TK_MENOR_IGUAL TK_DIFERENTE
%token TK_TRUE TK_FALSE
%token TK_OPERADORES_SOMA TK_OPERADORES_MULTI
%token TK_CONCAT


%start S
%left TK_OPERADORES_SOMA
%left TK_OPERADORES_MULTI
%left TK_AND TK_OR
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
				//declara as variaveis no inicio
				stringstream var;
				for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.
					var << "\n\t" << Tabela.at(i).tipo << " " << Tabela.at(i).tempVar << ";";
				}
				string t = var.str();
				stringstream valores;
				for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.
					valores << Tabela.at(i).valor;		
				}
				string z = valores.str();
				$$.traducao = t + z + $2.traducao;
			}
			;
COMANDOS	: COMANDO ';'COMANDOS{
				$$.traducao = $1.traducao + $3.traducao;
			}
			|{$$.traducao = "";}
			;
COMANDO 	: AUX { $$.traducao=  $1.traducao; }
		|DECLARACAO { $$.traducao=  $1.traducao; }
		|ATRIBUICAO { $$.traducao=  $1.traducao; }
		;
TK_TIPO: TK_TIPO_INT { $$.traducao=  $1.traducao; }
		 |TK_TIPO_FLOAT { $$.traducao=  $1.traducao; }
		 |TK_TIPO_HEX { $$.traducao=  $1.traducao; }
		 |TK_TIPO_STRING { $$.traducao=  $1.traducao; }
		;
DECLARACAO	:TK_TIPO TK_ID{
			//$$.traducao =  "\n\t" + $1.label + " " + $2.label + ";";
			$$.traducao = "";
			Tabela.push_back(node());
			Tabela[contVar].tipo = $1.label;
			Tabela[contVar].label = $2.label;
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			contVar++;
			}
			|TK_TIPO TK_ID TK_IGUAL E {				
				for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.
				   node temp = Tabela.at(i);
				   if (temp.tempVar.compare($4.traducao) == 0){
						Tabela.at(i).label = $2.label;
				   }
				}	
				$$.traducao = "";
					
			}			
			;
			
ATRIBUICAO :TK_ID TK_IGUAL VALOR_OP{						
				for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.
				   node temp = Tabela.at(i);
				   if (temp.label.compare($1.traducao) == 0){
						Tabela.at(i).label = $1.label;
						stringstream var;
						var <<"\n\t" << Tabela.at(i).tempVar <<  " = " << Tabela.at(i).conteudo << ";";
						Tabela.at(i).valor = var.str();
				   }
				}
				$$.traducao = "";			
				//$$.traducao =  "\n\t" + $1.label + $2.label + $3.traducao + ";";
			}
			;
AUX: E{
	$$.traducao = "";
}
E	:	E TK_OPERADORES_SOMA E {
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);		
			Tabela[contVar].label =  Tabela[contVar].tempVar;

			node temp;
			node temp_2;
			string tipoRetorno;
			for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.					
				   if ((Tabela.at(i).tempVar.compare($1.traducao) == 0) || (Tabela.at(i).label.compare($1.traducao) == 0)){				   
				   		temp = Tabela.at(i);	 	
				   }
				   if ((Tabela.at(i).tempVar.compare($3.traducao) == 0) || (Tabela.at(i).label.compare($3.traducao) == 0)){	
				   		temp_2 = Tabela.at(i);				   	
				   }
			}
			stringstream var;
			if(temp.tipo == temp_2.tipo){
				var <<"\n\t" << Tabela[contVar].tempVar  << "=" << temp.tempVar << $2.label << temp_2.tempVar << ";";
				Tabela[contVar].tipo =  temp.tipo;
			}
			else if(temp.tipo != "" && temp_2.tipo != ""){
				tipoRetorno = verificaTipo(temp.tipo,$2.label,temp_2.tipo);
				if(tipoRetorno == temp.tipo){
					var << "\n\t("+tipoRetorno+")"<< temp_2.tempVar << ";";
				}else{
					var << "\n\t("+tipoRetorno+")"<< temp.tempVar << ";";
				}				
				var << "\n\t" << Tabela[contVar].tempVar << "=" << temp.tempVar << $2.label << temp_2.tempVar << ";";
				Tabela[contVar].tipo =  tipoRetorno;
			}else if(temp.tipo != ""){
				Tabela[contVar].tipo =  temp.tipo;
				var <<"\n\t" << Tabela[contVar].tempVar  << "=" << "("+tipoRetorno+")"<< temp.tempVar << $2.label << temp_2.tempVar << ";";
			}else if(temp_2.tipo != ""){
				Tabela[contVar].tipo =  temp_2.tipo;
			}
			Tabela[contVar].valor = var.str();
			$$.traducao =  Tabela[contVar].tempVar;
			contVar++;	
		}
		|E TK_OPERADORES_MULTI E {  
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);			
			Tabela[contVar].label =  Tabela[contVar].tempVar;
			Tabela[contVar].tipo =  "int";
			node temp;
			node temp_2;
			for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.					
				   if ((Tabela.at(i).tempVar.compare($1.traducao) == 0) || (Tabela.at(i).label.compare($1.traducao) == 0)){				   
				   		temp.tempVar = Tabela.at(i).tempVar;	 	
				   }
				   if ((Tabela.at(i).tempVar.compare($3.traducao) == 0) || (Tabela.at(i).label.compare($3.traducao) == 0)){	
				   		temp_2.tempVar = Tabela.at(i).tempVar;				   	
				   }
			}
			stringstream var;
			var <<"\n\t" << Tabela[contVar].tempVar <<  " = " << temp.tempVar << $2.label << temp_2.tempVar << ";";
			Tabela[contVar].valor = var.str();
			$$.traducao =  Tabela[contVar].tempVar;
			contVar++;	
		}
		| '(' E ')'        { $$ .traducao= $2.traducao ; 
		}|E TK_MAIOR_IGUAL E 		{
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].tipo = "boolean";
			if(Tabela[contVar-2].valor >= Tabela[contVar-1].valor){
				Tabela[contVar].valor = "true";
			}else{Tabela[contVar].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[contVar].tempVar + " = " + Tabela[contVar-2].tempVar + " >= " + Tabela[contVar-1].tempVar +";\n";
			contVar++;
		}| E '>' E 		{
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].tipo = "boolean";
			if(Tabela[contVar-2].valor > Tabela[contVar-1].valor){
				Tabela[contVar].valor = "true";
			}else{Tabela[contVar].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[contVar].tempVar + " = " + Tabela[contVar-2].tempVar + " > " + Tabela[contVar-1].tempVar +";\n";
			contVar++;
		}|E TK_MENOR_IGUAL E 		{
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].tipo = "boolean";
			if(Tabela[contVar-2].valor <= Tabela[contVar-1].valor){
				Tabela[contVar].valor = "true";
			}else{Tabela[contVar].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[contVar].tempVar + " = " + Tabela[contVar-2].tempVar  + " <= " + Tabela[contVar-1].tempVar + ";\n";
			contVar++;
		}|E '<' E 		{
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].tipo = "boolean";
			if(Tabela[contVar-2].valor < Tabela[contVar-1].valor){
				Tabela[contVar].valor = "true";
			}else{Tabela[contVar].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[contVar].tempVar + " = " + Tabela[contVar-2].tempVar  + " < " + Tabela[contVar-1].tempVar + ";\n";
			contVar++;
		}|E TK_DIFERENTE E 		{
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].tipo = "boolean";
			if(Tabela[contVar-2].valor != Tabela[contVar-1].valor){
				Tabela[contVar].valor = "true";
			}else{Tabela[contVar].valor = "false";}
			$$.traducao = $1.traducao  + $3.traducao + "\n\t" + Tabela[contVar].tempVar + " = " + Tabela[contVar-2].tempVar  + " != " + Tabela[contVar-1].tempVar + ";\n";
			contVar++;
		}	
		|E TK_AND E {
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].valor =  Tabela[contVar-1].valor + " && " + Tabela[contVar-2].valor;
			if(Tabela[contVar-1].tipo.compare(Tabela[contVar-2].tipo) == 0){
				$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[contVar-1].tipo + " " + Tabela[contVar].tempVar +  " = " + Tabela[contVar-1].tempVar + " && " + Tabela[contVar-2].tempVar +";";	
				Tabela[contVar].tipo = Tabela[contVar-1].tipo;
			}			
			else{
				yyerror("Tipos diferentes");
			}	
			contVar++;
		}	
		|E TK_OR E {
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].valor =  Tabela[contVar-1].valor + " || " + Tabela[contVar-2].valor;
			
			$$.traducao =   $1.traducao  + $3.traducao + "\n\t" + Tabela[contVar-1].tipo + " " + Tabela[contVar].tempVar +  " = " + Tabela[contVar-1].tempVar + " || " + Tabela[contVar-2].tempVar +";";	
			Tabela[contVar].tipo = Tabela[contVar-1].tipo;
			
			contVar++;
		}
		| E TK_CONCAT E {
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);			
			Tabela[contVar].label =  Tabela[contVar].tempVar;
			Tabela[contVar].tipo =  "char";

			node temp;
			node temp_2;
			for(int i = 0; i < Tabela.size(); i++) { // Percorre o vector procurando o label da variavel.					
				   if ((Tabela.at(i).tempVar.compare($1.traducao) == 0) || (Tabela.at(i).label.compare($1.traducao) == 0)){				   
				   		temp.tempVar = Tabela.at(i).tempVar;	 	
				   }
				   if ((Tabela.at(i).tempVar.compare($3.traducao) == 0) || (Tabela.at(i).label.compare($3.traducao) == 0)){	
				   		temp_2.tempVar = Tabela.at(i).tempVar;				   	
				   }
			}

			int tamanho;
			tamanho = temp.tempVar.size() + temp_2.tempVar.size();

			stringstream var;
			var <<"\n\t" << "strcpy(" << Tabela[contVar].tempVar <<" , " << temp.tempVar << ");";
			var <<"\n\t" << "strcat(" << Tabela[contVar].tempVar <<" , " << temp_2.tempVar << ");";
			Tabela[contVar].valor = var.str();

			$$.traducao =  Tabela[contVar].tempVar;
			contVar++;	
		}	
		| VALOR_OP { $$.traducao=  $1.traducao; }
		| BOOLEAN { $$.traducao=  $1.traducao; }
		| TK_ID { $$.traducao=  $1.label; }
		;
BOOLEAN: TK_TRUE { 
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].valor = $1.traducao;
			Tabela[contVar].tipo = "bool";
			$$.traducao =  "\n\tbool " + Tabela[contVar].tempVar + " = " + $1.label + ";";
			contVar++;
		}
		 |TK_FALSE{ 
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);
			Tabela[contVar].valor = $1.traducao;
			Tabela[contVar].tipo = "bool";
			$$.traducao =  "\n\tbool " + Tabela[contVar].tempVar + " = " + $1.label + ";";
			contVar++;
		}
// Recebe todos os valores
VALOR_OP:  TK_DECIMAL { 
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);			
			Tabela[contVar].tipo = "int";
			Tabela[contVar].conteudo = $1.traducao;
			stringstream var;
			var <<"\n\t" << Tabela[contVar].tempVar << " = " << $1.traducao << ";";
			Tabela[contVar].valor = var.str();
			
			$$.traducao = Tabela[contVar].tempVar;
			contVar++;
		}
		| TK_FLOAT { 
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);			
			Tabela[contVar].tipo = "float";
			stringstream var;
			var <<"\n\t" << Tabela[contVar].tempVar << " = " << $1.traducao << ";";
			Tabela[contVar].valor = var.str();
			
			$$.traducao = Tabela[contVar].tempVar;
			contVar++;
		 }
		| TK_HEX { 
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);			
			Tabela[contVar].tipo = "hex";
			stringstream var;
			var <<"\n\t" << Tabela[contVar].tempVar << " = " << $1.traducao << ";";
			Tabela[contVar].valor = var.str();
			
			$$.traducao = Tabela[contVar].tempVar;
			contVar++;
		 }
		| TK_STRING {
			Tabela.push_back(node());
			Tabela[contVar].tempVar = geraVariavel2(contVar);	

			Tabela[contVar].tipo = "char";
			int tamanho;
			tamanho = $1.traducao.size();
			
			//strcpy(Tabela[contVar].tempVar, $1.traducao);


			stringstream var;
			var <<"\n\t" << "char[" << tamanho << "] " <<  Tabela[contVar].tempVar << ";";
			var <<"\n\t" << "strcpy(" << Tabela[contVar].tempVar <<" , " << $1.traducao << ");";
			Tabela[contVar].valor = var.str();
			
			$$.traducao = Tabela[contVar].tempVar;
			contVar++;
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