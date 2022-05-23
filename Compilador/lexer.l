%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "syntax.tab.h"
	extern int yyparse();

	void error(char *msg){
		printf("%s\n",msg);
	}
	int line_count = 1;
%}

%option noyywrap

%x str
%x comment
comment_simp		("--"[^"\n]*("--")*)

digit					[0-9]
up_letter				[A-Z]
lo_letter				[a-z]
letters					[a-zA-Z]
white_space				(" "|\\f|\\r|\\t|\\v|\\n)
assign					("<-")
req      				("=>")
leq	        			("<=")

string					(\"[^"\n]*\")
type_id					("SELF_TYPE"|{up_letter}("_"|{letters}|{digit})*)
object_id				("self"|{lo_letter}("_"|{letters}|{digit})*)

let						[lL][eE][tT]
if						[iI][fF]
then					[tT][hH][eE][nN]
else 					[eE][lL][sS][eE]
fi						[fF][iI]
while					[wW][hH][iI][lL][eE]
loop					[lL][oO][oO][pP]
pool					[pP][oO][oO][lL]
case					[cC][aA][sS][eE]
esac					[eE][sS][aA][cC]
new						[nN][eE][wW]
inherits				[iI][nN][hH][eE][rR][iI][tT][sS]
in						[iI][nN]
of						[oO][fF]
not						[nN][oO][tT]
isvoid					[iI][sS][vV][oO][iI][dD]
class					[cC][lL][aA][sS][sS]
boolean_true			[t][rR][uU][eE]
boolean_false			[f][aA][lL][sS][eE]

other 					("!"|">")
%%


{let}					return t_let;
{if}					return t_if;
{then}					return t_then;
{else}					return t_else;
{fi}					return t_fi;
{while}					return t_while;
{loop}					return t_loop;
{pool}					return t_pool;
{case}					return t_case;
{esac}					return t_esac;
{new}					return t_new;
{inherits}				return t_inherits;
{in}					return t_in;
{of}					return t_of;
{not}					return t_not;
{isvoid}				return t_isvoid;
{class}					return t_class;
{boolean_true}			return t_bool_t;
{boolean_false}			return t_bool_f;

"+"						return t_op_add;
"-"						return t_op_sub;
"/"						return t_op_div;
"*"						return t_op_mul;

{type_id}				return t_id_type;
{object_id}				return t_id_obj;
{digit}+ 				return t_int;
{assign}				return t_ass;
{leq}					return t_leq;
{req}					return t_req;

"~"						return t_neg;
"<"						return t_less;
"="						return t_equal;
"("						return t_open_par;
")"						return t_close_par;
"{"						return t_open_curly;
"}"						return t_close_curly;
"."						return t_dot;
","						return t_comma;
":"						return t_colon;
";"						return t_semicolon;
"@" 					return t_at;

\n 						{ ++line_count; }
{other}						;
{white_space}+				;
{comment_simp}			{++line_count;};

"(*"          { BEGIN(comment); }
<comment>"*)" { BEGIN(INITIAL); }
<comment>\n   { ++line_count; }
<comment>.    { }

{string}				return t_string;
\"			{ BEGIN(str); }
<str>\"	  	{ BEGIN(INITIAL); }
<str>\n	  	{error("Error: string not closed\n");}
<str>.	  	{ }

%%



