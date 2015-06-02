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
DELIM 		{SPACE}+
ID {CHAR}({CHAR}|{DIGIT})*
STRING {CHAR}?\"(\\.|[^\\"])*\"|{CHAR}?\'(\\.|[^\\'])*\'


%%

int					{yylval.label = yytext;return TK_TIPO_INT;}
float				{yylval.label = yytext;return TK_TIPO_FLOAT;}
string              {yylval.label = yytext;return TK_TIPO_STRING;}
hex 				{yylval.label = yytext;return TK_TIPO_HEX;}
"\n"					{}
"="				{yylval.label = yytext; return	TK_IGUAL;}
-------Tipos
{DECIMAL}				{yylval.traducao = yytext; return TK_DECIMAL;}
-{DECIMAL}              {yylval.traducao = yytext; return TK_N_DECIMAL;}
{HEX}					{yylval.traducao = yytext; return TK_HEX;; }
{FLOAT}					{yylval.traducao = yytext;return TK_FLOAT;}
-{FLOAT}				{printf("encontrei um  -- FLOAT \n"); }
{STRING}				{yylval.traducao = yytext; return TK_STRING;}
{DELIM}					{}



-------PalavrasReservadas
"#"                                 	{printf("encontrei o # \n");}
"auto"					{printf("encontrei o auto \n");}
"and"					{printf("encontrei o and \n"); }
"boolean"				{printf("encontrei o boolean \n");}
"break"					{printf("encontrei o break \n");}
"case"                                  {printf("encontrei o case \n");}
"char"                                  {printf("encontrei o char \n");}
"cin"					{printf("encontrei o cin \n");}
"cout"					{printf("encontrei o cout \n");}
"const" 				{printf("encontrei o const \n");}
"continue"				{printf("encontrei o continue \n");}
"define"                  		{printf("encontrei o define \n");}
"double"				{printf("encontrei o double \n");}
"default"				{printf("encontrei o default \n");}
"do" 					{printf("encontrei o do \n");}
"else"                      		{printf("encontrei o else \n");}
"elseif"                        	{printf("encontrei o elseif \n");}
"for"					{printf("encontrei o for \n");}
"for each"				{printf("encontrei o for each \n");}

"if" 					{printf("encontrei o if \n"); }
"go to"					{printf("enconteri o go To \n");}
"include"                               {printf("encontrei o include \n");}
"long"					{printf("encontrei o long \n");}
"main"					{return TK_MAIN;}
"or"									{printf("encontrei o OR\n ");}
"return"								{printf("encontrei o return \n");}
"short"									{printf("encontrei o short \n");}
"sizeof"								{printf("encontrei o sizeof \n");}
"static"								{printf("encontrei o static \n");}
"struct"								{printf("encontrei o struct \n");}
"switch"								{printf("encontrei o switch \n");}
"typedef"								{printf("encontrei o typedef \n");}
"void"									{printf("encontrei o void \n");}
"while"									{printf("encontrei o while \n");}

-------Delimitadores
"!="									{yylval.label = yytext; return TK_DIFERENTE;}
"=="									{yylval.label = yytext; return TK_IGUAL_IGUAL;}
"<="									{yylval.label = yytext; return TK_MENOR_IGUAL;}
">="									{yylval.label = yytext; return TK_MAIOR_IGUAL;}
[(){}[\];,] 							{return *yytext;}
">"										{return *yytext;}
"<"										{return *yytext;}
":"									{printf("encontrei o  : \n"); }
"\'"									{printf("encontrei a aspas simples \n"); }
"\""									{printf("encontrei a aspas duplas \n"); }

">>"									{printf("encontrei o >> \n"); }
"..."									{printf("encontrei o ... \n");}

"//"									{printf("encontrei o comentario de uma linha \n");}
"/*"									{printf("encontrei o abre comentario varias linhas \n");}
"*/"									{printf("encontrei o fecha omentario varias linhas \n");}



-------Operadores
[+\-*/]		{return *yytext; }
"^"										{printf("encontrei o ^ \n");}
"&"										{printf("encontrei o & \n");}
"!"										{printf("encontrei o ! \n");}
"|"										{printf("encontrei o | \n");}
"~"										{printf("encontrei o ~ (complemento) \n");}
"++"									{printf("encontrei o mais mais \n");}
"--"									{printf("encontrei o menos menos \n");}
"+="									{printf("encontrei o += \n");}
"-="									{printf("encontrei o -= \n");}
"*="									{printf("encontrei o *= \n");}
"/="									{printf("encontrei o /= \n");}
"|="									{printf("encontrei o |= \n");}
"^⁼"									{printf("encontrei o ^= \n");}
"&="									{printf("encontrei o &= \n");}
"&&"									{printf("encontrei o && \n");}
"||"									{printf("encontrei o || \n");}
"<<="									{printf("encontrei o <<= \n");}
">>="									{printf("encontrei o >>= \n");}
"?"										{printf("encontrei o ? \n");}

{ID}					{ yylval.label = yytext; return TK_ID; }
.				{printf("ponto \n"); *yytext; }
%%
