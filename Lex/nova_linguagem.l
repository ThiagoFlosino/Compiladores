%{

#define X 001 //Variavel_para_verificar_Fim_Arquivo_ EOF




%}
DIGIT 		[0-9]
HEX 		0x[0-9A-Fa-f]+
FLOAT 		{DIGIT}*\.{DIGIT}+|{DIGIT}+\.{DIGIT}*
DECIMAL 	{DIGIT}+
OCTAL		[0-7]
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
#                                 		{printf("encontrei o # \n");}
auto									{printf("encontrei o auto \n");}
"and"									{printf("encontrei o and \n"); }
boolean									{printf("encontrei o boolean \n");}
break									{printf("encontrei o break \n");}
case                                    {printf("encontrei o case \n");}
char                                    {printf("encontrei o char \n");}
cin										{printf("encontrei o cin \n");}
cout									{printf("encontrei o cout \n");}
const 									{printf("encontrei o const \n");}
continue								{printf("encontrei o continue \n");}
define                                  {printf("encontrei o define \n");}
double									{printf("encontrei o double \n");}
default									{printf("encontrei o default \n");}
do 										{printf("encontrei o do \n");}
else                                    {printf("encontrei o else \n");}
elseif                                  {printf("encontrei o elseif \n");}
for										{printf("encontrei o for \n");}
"for each"								{printf("encontrei o for each \n");}
float									{printf("encontrei o float \n");}
if 										{printf("encontrei o if \n"); }
"go to"									{printf("enconteri o go To \n");}
int										{printf("encontrei o int \n"); }
include                                 {printf("encontrei o include \n");}
long									{printf("encontrei o long \n");}
main									{printf("encontrei o main \n");}
or										{printf("encontrei o OR\n ");}
return									{printf("encontrei o return \n");}
string                                  {printf("encontrei o string \n");}
switch									{printf("encontrei o switch \n");}
short									{printf("encontrei o short \n");}
sizeof									{printf("encontrei o sizeof \n");}
static									{printf("encontrei o static \n");}
struct									{printf("encontrei o struct \n");}
switch									{printf("encontrei o switch \n");}
typedef									{printf("encontrei o typedef \n");}
void									{printf("encontrei o void \n");}
while									{printf("encontrei o while \n");}

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
"<<"									{printf("encontrei o << \n"); }
">>"									{printf("encontrei o >> \n"); }
"..."									{printf("encontrei o ... \n");}
"->"									{printf("encontrei o ->");}
"/"										{printf("encontrei o \\  vezes \n");}
"//"									{printf("encontrei o comentario de uma linha \n");}
"/*"									{printf("encontrei o abre comentario varias linhas \n");}
"*/"									{printf("encontrei o fecha omentario varias linhas \n");}



-------Operadores
"+"										{printf("encontrei o mais \n");}
"-"										{printf("encontrei o menos \n");}
"*"										{printf("encontrei o  * vezes \n");}
"/"										{printf("encontrei o / \n");}
"^"										{printf("encontrei o ^ \n");}
"!="									{printf("encontrei o != \n");}
"&"										{printf("encontrei o & \n");}
"%"										{printf("encontrei o % \n");}
"!"										{printf("encontrei o ! \n");}
"|"										{printf("encontrei o | \n");}
"~"										{printf("encontrei o ~ (complemento) \n");}
"++"									{printf("encontrei o mais mais \n");}
"--"									{printf("encontrei o menos menos \n");}
"=="									{printf("encontrei o == \n");}
"+="									{printf("encontrei o += \n");}
"-="									{printf("encontrei o -= \n");}
"*="									{printf("encontrei o *= \n");}
"/="									{printf("encontrei o /= \n");}
"<="									{printf("encontrei o <= \n");}
">="									{printf("encontrei o >= \n");}
"%="									{printf("encontrei o %= \n");}
"|="									{printf("encontrei o |= \n");}
"^⁼"									{printf("encontrei o ^= \n");}
"&="									{printf("encontrei o &= \n");}
"&&"									{printf("encontrei o && \n");}
"||"									{printf("encontrei o || \n");}
"<<="									{printf("encontrei o <<= \n");}
">>="									{printf("encontrei o >>= \n");}
"?"										{printf("encontrei o ? \n");}

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
