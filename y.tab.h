/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

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
    TK_MAIN = 262,
    TK_ERRO = 263,
    TK_ID = 264,
    TK_IGUAL = 265,
    TK_DECIMAL = 266,
    TK_N_DECIMAL = 267,
    TK_FLOAT = 268,
    TK_HEX = 269,
    TK_STRING = 270,
    TK_MAIOR_IGUAL = 271,
    TK_IGUAL_IGUAL = 272,
    TK_MENOR_IGUAL = 273,
    TK_DIFERENTE = 274,
    TK_TRUE = 275,
    TK_FALSE = 276,
    TK_OPERADORES = 277,
    NUM = 278,
    TK_AND = 279,
    TK_OR = 280,
    NEG = 281
  };
#endif
/* Tokens.  */
#define TK_TIPO_INT 258
#define TK_TIPO_FLOAT 259
#define TK_TIPO_STRING 260
#define TK_TIPO_HEX 261
#define TK_MAIN 262
#define TK_ERRO 263
#define TK_ID 264
#define TK_IGUAL 265
#define TK_DECIMAL 266
#define TK_N_DECIMAL 267
#define TK_FLOAT 268
#define TK_HEX 269
#define TK_STRING 270
#define TK_MAIOR_IGUAL 271
#define TK_IGUAL_IGUAL 272
#define TK_MENOR_IGUAL 273
#define TK_DIFERENTE 274
#define TK_TRUE 275
#define TK_FALSE 276
#define TK_OPERADORES 277
#define NUM 278
#define TK_AND 279
#define TK_OR 280
#define NEG 281

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
