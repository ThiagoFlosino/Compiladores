/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TK_TIPO_INT = 258,
    TK_TIPO_FLOAT = 259,
    TK_TIPO_STRING = 260,
    TK_TIPO_HEX = 261,
    TK_TIPO_BOOL = 262,
    TK_MAIN = 263,
    TK_ERRO = 264,
    TK_ID = 265,
    TK_IGUAL = 266,
    TK_DECIMAL = 267,
    TK_N_DECIMAL = 268,
    TK_FLOAT = 269,
    TK_HEX = 270,
    TK_STRING = 271,
    TK_MAIOR_IGUAL = 272,
    TK_IGUAL_IGUAL = 273,
    TK_MENOR_IGUAL = 274,
    TK_DIFERENTE = 275,
    TK_TRUE = 276,
    TK_FALSE = 277,
    TK_OPERADORES_SOMA = 278,
    TK_OPERADORES_MULTI = 279,
    TK_CONCAT = 280,
    TK_MAIOR = 281,
    TK_OPERADORES_LOGICOS = 282,
    TK_AND = 283,
    TK_OR = 284
  };
#endif
/* Tokens.  */
#define TK_TIPO_INT 258
#define TK_TIPO_FLOAT 259
#define TK_TIPO_STRING 260
#define TK_TIPO_HEX 261
#define TK_TIPO_BOOL 262
#define TK_MAIN 263
#define TK_ERRO 264
#define TK_ID 265
#define TK_IGUAL 266
#define TK_DECIMAL 267
#define TK_N_DECIMAL 268
#define TK_FLOAT 269
#define TK_HEX 270
#define TK_STRING 271
#define TK_MAIOR_IGUAL 272
#define TK_IGUAL_IGUAL 273
#define TK_MENOR_IGUAL 274
#define TK_DIFERENTE 275
#define TK_TRUE 276
#define TK_FALSE 277
#define TK_OPERADORES_SOMA 278
#define TK_OPERADORES_MULTI 279
#define TK_CONCAT 280
#define TK_MAIOR 281
#define TK_OPERADORES_LOGICOS 282
#define TK_AND 283
#define TK_OR 284

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
