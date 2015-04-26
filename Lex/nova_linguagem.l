%{

#define X 001 //Variavel_para_verificar_Fim_Arquivo_ EOF




%}
DIGIT 		[0-9]
HEX 		0x[0-9A-Fa-f]+
FLOAT 		{DIGIT}*\.{DIGIT}+|{DIGIT}+\.{DIGIT}*
DECIMAL 	{DIGIT}+
CHAR 		[a-zA-Z]
SPACE   	[\ \t]


%%

-------Tipos
{DECIMAL}								{printf("encontrei um numero decimal \n"); }
-{DECIMAL}                              {printf("encontrei o numero com sinal \n");}
{HEX}									{printf("encontrei um hex \n"); }
{FLOAT}									{printf("encontrei um FLOAT \n"); }
-{FLOAT}								{printf("encontrei um  -- FLOAT \n"); }
{CHAR}									{printf("encontrei um CHAR \n"); }
{SPACE}									{printf("ENCONTREI O ESPAÇO OU O TAB\n");}

-------PalavrasReservadas
if 										{printf("encontrei o if \n"); }
while									{printf("encontrei o while \n");}
for										{printf("encontrei o for \n");}
"for each"								{printf("encontrei o for each \n");}
main									{printf("encontrei o main \n");}
else                                    {printf("encontrei o else \n");}
elseif                                  {printf("encontrei o elseif \n");}
int										{printf("encontrei o int \n"); }
string                                  {printf("encontrei o string \n");}
float									{printf("encontrei o float \n");}
double									{printf("encontrei o double \n");}
char                                    {printf("encontrei o char \n");}
boolean									{printf("encontrei o boolean \n");}
"go to"									{printf("enconteri o go To \n");}
"and"									{printf("encontrei o and \n"); }
or										{printf("encontrei o OR\n ");}
switch									{printf("encontrei o switch \n");}
case                                    {printf("encontrei o case \n");}

-------Delimitadores
"{"										{printf("encontrei o abre chaves \n");}
"}"										{printf("encontrei o fecha chaves \n");}
"." 									{printf("encontrei o . vezes \n");}
";"										{printf("encontrei o ; \n"); }
"["										{printf("encontrei o  [ \n"); }
"]"										{printf("encontrei o  ] \n"); }
"("										{printf("encontrei o  ( \n"); }
")"										{printf("encontrei o  ) \n"); }
":"										{printf("encontrei o  : \n"); }
"\'"									{printf("encontrei a aspas simples \n"); }
"\""									{printf("encontrei a aspas duplas \n"); }

-------Operadores
"+"										{printf("encontrei o mais \n");}
"++"									{printf("encontrei o mais mais \n");}
"-"										{printf("encontrei o menos \n");}
"--"									{printf("encontrei o menos menos \n");}
"*"										{printf("encontrei o  * vezes \n");}
"/"										{printf("encontrei o \\  vezes \n");}


<<EOF>>                                 { return X; }
%%


int main(int argc, char *argv[])
{
          FILE *f_in;
          int tipoToken;
         

          if(argc == 2)
          {
                    if(f_in == fopen(argv[1], "r"))
                    {
                              yyin = f_in;
                    }
                    else
                    {
                              perror(argv[0]);
                    }
          }
          else
          {
                    yyin = stdin;
          }

          while((tipoToken = yylex()) != X)
          {
                    
          }

}
