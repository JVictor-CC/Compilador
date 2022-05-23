
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     t_let = 258,
     t_if = 259,
     t_then = 260,
     t_else = 261,
     t_fi = 262,
     t_while = 263,
     t_loop = 264,
     t_pool = 265,
     t_case = 266,
     t_esac = 267,
     t_new = 268,
     t_inherits = 269,
     t_in = 270,
     t_of = 271,
     t_not = 272,
     t_isvoid = 273,
     t_class = 274,
     t_bool_f = 275,
     t_bool_t = 276,
     t_op_add = 277,
     t_op_sub = 278,
     t_op_div = 279,
     t_op_mul = 280,
     t_int = 281,
     t_string = 282,
     t_id_obj = 283,
     t_id_type = 284,
     t_ass = 285,
     t_req = 286,
     t_leq = 287,
     t_neg = 288,
     t_less = 289,
     t_equal = 290,
     t_open_par = 291,
     t_close_par = 292,
     t_open_curly = 293,
     t_close_curly = 294,
     t_dot = 295,
     t_comma = 296,
     t_colon = 297,
     t_at = 298,
     t_semicolon = 10
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


