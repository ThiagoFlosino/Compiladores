%{
#define ND            001
#define NDN         002
#define NF            003
#define NFN         004
#define NH           005
#define B 304
#define X 399
#define Z 400
#define F 033




%}
DIGIT     [0-9]
HEX       0x[0-9A-Fa-f]+
FLOAT {DIGIT}*\.{DIGIT}+|{DIGIT}+\.{DIGIT}*
DECIMAL {DIGIT}+
CHAR [a-zA-Z]
SPACE   [\ \t]

%%

-------Tipo

{DECIMAL}                               {printf("encontrei um numero decimal \n"); return A; }
-{DECIMAL}                              {printf("encontrei o numero com sinal \n");return A;}
{HEX}                                       {printf("encontrei um hex \n"); return A;}
{FLOAT}                                   {printf("encontrei um FLOAT \n"); return A;}
-{FLOAT}                                  {printf("encontrei um  -- FLOAT \n"); return A;}
{CHAR}                                    {printf("encontrei um CHAR \n"); return A;}
{SPACE}                                   {printf("ENCONTREI O ESPAÇO OU O TAB\n");return A;}

-------PalavrasReservadas

if                                         {printf("encontrei o if \n"); return A;}
while                                  {printf("encontrei o while \n");return A;}
for                                      {printf("encontrei o for \n");return A;}
main                                  {printf("encontrei o main \n");return A;}
else                                    {printf("encontrei o else \n");return A;}
elseif                                  {printf("encontrei o elseif \n");return A;}
int                                       {printf("encontrei o int \n"); return Z;}
string                                  {printf("encontrei o string \n");return A;}
float                                    {printf("encontrei o float \n");return A;}
double                                {printf("encontrei o double \n");return A;}
char                                    {printf("encontrei o char \n");return A;}
boolean                              {printf("encontrei o boolean \n");return A;}
"go to"                                {printf("enconteri o go To \n");return A;}
"and"                                  {printf("encontrei o and \n"); return A;}
or                                        {printf("encontrei o OR\n ");return A;}
switch                                 {printf("encontrei o switch \n");return A;}
case                                    {printf("encontrei o case \n");return A;}


-------Delimitadores
"{"                                               {printf("encontrei o abre chaves \n");return A;}
"}"                                               {printf("encontrei o fecha chaves \n");return A;}
"."                                                {printf("encontrei o . vezes \n");return A;}
";"                                                {printf("encontrei o ; \n"); return A;}
"["                                                {printf("encontrei o  [ \n"); return A;}
"]"                                                {printf("encontrei o  ] \n"); return A;}
"("                                                {printf("encontrei o  ( \n"); return A;}
")"                                                {printf("encontrei o  ) \n"); return A;}
":"                                                {printf("encontrei o  : \n"); return A;}
"\'"                                               {printf("encontrei a aspas simples \n"); return A;}
"\""                                              {printf("encontrei a aspas duplas \n"); return A;}

-------Operadores
"+"                                               {printf("encontrei o mais \n");return A;}
"++"                                            {printf("encontrei o mais mais \n");return A;}
"-"                                                {printf("encontrei o menos \n");return A;}
"--"                                               {printf("encontrei o menos menos \n");return A;}
"*"                                                {printf("encontrei o  * vezes \n");return A;}
"/"                                                 {printf("encontrei o \\  vezes \n");return A;}


<<EOF>>                                 { return X; }
%%

int main(int argc, char *argv[])
{
          FILE *f_in;
          int tipoToken;
          int totalDec = 0,
                    totalOct = 0,
                    totalHex = 0,
                    totalFlt = 0;

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
                    switch (tipoToken)
                    {
                              case D:
                                        ++totalDec;
                                        break;
                              case O:
                                        ++totalOct;
                                        break;
                              case H:
                                        ++totalHex;
                                        break;
                              case F:
                                        ++totalFlt;
                                        break;
                    }
          }

}
