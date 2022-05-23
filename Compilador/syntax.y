%{
    #include <stdio.h>
    extern int yylex();
    extern FILE *yyin;
    void yyerror();
    extern int line_count;
%}

%start program
%token t_let t_if t_then t_else t_fi t_while t_loop t_pool t_case t_esac t_new t_inherits t_in t_of t_not t_isvoid t_class t_bool_f t_bool_t 
%token t_op_add t_op_sub t_op_div t_op_mul 
%token t_int t_string t_id_obj t_id_type 
%token t_ass t_req t_leq t_neg t_less t_equal t_open_par t_close_par t_open_curly t_close_curly t_dot t_comma t_colon t_semicolon t_at


//%precedence t_dot
//%precedence t_at
//%precedence t_neg
//%precedence t_isvoid
%left t_op_mul t_op_div
%left t_op_add t_op_sub
%nonassoc t_less t_equal t_leq
//%precedence t_not
%right t_ass

%%
program:
    classes     {printf("Program -> classes\nlinha: %d\n\n",line_count);}
;

classes:
    class       {printf("classes -> class\nlinha: %d\n\n",line_count);} 
    |   classes class   {printf("classes -> classes class\nlinha: %d\n\n",line_count);}
;

class:
    t_class t_id_type t_open_curly features t_close_curly t_semicolon    {printf("class -> CLASS TYPEID { features } ;\nlinha: %d\n\n",line_count);}
    |   t_class t_id_type t_inherits t_id_type t_open_curly features t_close_curly t_semicolon    {printf("class -> CLASS TYPEID INHERITS TYPEID { features } ;\nlinha: %d\n\n",line_count);}

features:
    feature     {printf("features -> feature\nlinha: %d\n\n",line_count);}
    |   features feature    {printf("features -> features feature\nlinha: %d\n\n",line_count);}
    |           {printf("features -> none\nlinha: %d\n\n",line_count);}
;

feature:
    attribute t_semicolon   {printf("feature -> attribute ;\nlinha: %d\n\n",line_count);}
    |   method t_semicolon  {printf("feature -> method ;\nlinha: %d\n\n",line_count);}
;

attribute:
    t_id_obj t_colon t_id_type      {printf("attribute -> OBJECTID : TYPEID\nlinha: %d\n\n",line_count);}
    |   t_id_obj t_colon t_id_type t_ass t_open_curly expr t_close_curly       {printf("attribute -> OBJECTID : TYPEID assign { expression }\nlinha: %d\n\n",line_count);}
    |   t_id_obj t_colon t_id_type t_ass expr       {printf("attribute -> OBJECTID : TYPEID assign expression\nlinha: %d\n\n",line_count);}
;

method:
    t_id_obj t_open_par formals t_close_par t_colon t_id_type t_open_curly expr t_close_curly     {printf("method -> OBJECTID ( formals ) : TYPEID { expression }\nlinha: %d\n\n",line_count);}
;

formals:
    formal      {printf("formals -> formal\nlinha: %d\n\n",line_count);}
    |   formals t_comma formal      {printf("formals -> formals , formal\nlinha: %d\n\n",line_count);}
    |           {printf("formals -> none\nlinha: %d\n\n",line_count);}
;

formal:
    t_id_obj t_colon t_id_type      {printf("formal -> OBJECTID : TYPEID\nlinha: %d\n\n",line_count);} 
;

expr:
    t_id_obj t_ass expr     {printf("expression -> OBJECTID assign expression\nlinha: %d\n\n",line_count);}

    |   t_if expr t_then expr t_else expr t_fi      {printf("expression -> IF expression THEN expression ELSE expression FI\nlinha: %d\n\n",line_count);}

    |   firstexpressions    {printf("expression -> firstexpression\nlinha: %d\n\n",line_count)}

    |   t_while expr t_loop expr t_pool     {printf("expression -> WHILE expression LOOP expression POOL\nlinha: %d\n\n",line_count);}

    |   t_open_curly curly_expressions t_close_curly     {printf("expression -> { curly_expressions }\nlinha: %d\n\n",line_count);}

    |   t_let letexpr       {printf("expression -> LET let_declaration \nlinha: %d\n\n",line_count);}

    |   t_case expr t_of caseexpr t_esac        {printf("expression -> CASE expression OF case_expression ESAC\nlinha: %d\n\n",line_count);}

    |   t_new t_id_type     {printf("expression -> NEW TYPEID\nlinha: %d\n\n",line_count);}

    |   t_isvoid expr       {printf("expression -> ISVOID expression\nlinha: %d\n\n",line_count);}

    |   expr t_op_add expr      {printf("expression -> expression + expression\nlinha: %d\n\n",line_count);}

    |   expr t_op_sub expr      {printf("expression -> expression - expression\nlinha: %d\n\n",line_count);}

    |   expr t_op_mul expr      {printf("expression -> expression * expression\nlinha: %d\n\n",line_count);}

    |   expr t_op_div expr      {printf("expression -> expression / expression\nlinha: %d\n\n",line_count);}

    |   t_neg expr      {printf("expression -> ~ expression\nlinha: %d\n\n",line_count);}

    |   expr t_less expr    {printf("expression -> expression < expression\nlinha: %d\n\n",line_count);}

    |   expr t_leq expr     {printf("expression -> expression <= expression\nlinha: %d\n\n",line_count);}

    |   expr t_equal expr       {printf("expression -> expression = expression\nlinha: %d\n\n",line_count);}

    |   t_not expr      {printf("expression -> NOT expression\nlinha: %d\n\n",line_count);}

    |   t_open_par expr t_close_par        {printf("expression -> ( expression )\nlinha: %d\n\n",line_count);}

    |   t_id_obj        {printf("expression -> OBJECTID\nlinha: %d\n\n",line_count);}

    |   t_int       {printf("expression -> INTEGER\nlinha: %d\n\n",line_count);}

    |   t_string        {printf("expression -> STRING\nlinha: %d\n\n",line_count);}

    |   t_bool_t        {printf("expression -> TRUE\nlinha: %d\n\n",line_count);}

    |   t_bool_f        {printf("expression -> FALSE\nlinha: %d\n\n",line_count);}

;

curly_expressions:
    expression      {printf("curly_expression -> expression\nlinha: %d\n\n",line_count);}
    |   curly_expressions expression      {printf("curly_expression -> curly_expression expression\nlinha: %d\n\n",line_count);}
;

expression:
    expr t_semicolon        {printf("expression -> expression ;\nlinha: %d\n\n",line_count);}
;

letexpr:
    t_id_obj t_colon t_id_type letassign t_in expr      {printf("let_declaration -> OBJECTID : TYPEID let_assign IN expression\nlinha: %d\n\n",line_count);}
    |   t_id_obj t_colon t_id_type letassign t_comma letexpr        {printf("let_declaration -> OBJECTID : TYPEID let_assign , let_declaration\nlinha: %d\n\n",line_count);}
;

letassign:
    t_ass expr      {printf("let_assign -> assign expression\nlinha: %d\n\n",line_count);}
    |               {printf("let_assign -> none\nlinha: %d\n\n",line_count);}
;

caseexpr:
    case        {printf("case_expression -> cases")}
    |   caseexpr case       {printf("case_expression -> case_expression cases\nlinha: %d\n\n",line_count);}
;

case:
    t_id_obj t_colon t_id_type t_req expr t_semicolon        {printf("cases -> OBJECTID : TYPEID => expression ;\nlinha: %d\n\n",line_count);}
;

firstexpressions : 
    t_id_obj t_open_par t_close_par        {printf("first_expressions -> OBJECTID (  )\nlinha: %d\n\n",line_count);}
    
    |   t_id_obj t_open_par expr t_close_par     {printf("first_expressions -> OBJECTID ( expression )\nlinha: %d\n\n",line_count);} 
    
    | t_id_obj t_open_par expr more_expressions  t_close_par        {printf("first_expressions -> OBJECTID ( expression more_expressions )\nlinha: %d\n\n",line_count);}
    
    | expr t_dot t_id_obj t_open_par t_close_par     {printf("first_expressions -> expression . OBJECTID (  )\nlinha: %d\n\n",line_count);}
    
    | expr t_dot t_id_obj t_open_par expr t_close_par        {printf("first_expressions -> expression . OBJECTID ( expression )\nlinha: %d\n\n",line_count);}
    
    | expr t_dot t_id_obj t_open_par expr more_expressions t_close_par      {printf("first_expressions -> expression . OBJECTID ( expression more_expressions )\nlinha: %d\n\n",line_count);}
    
    | expr t_at t_id_type t_dot t_id_obj t_open_par t_close_par       {printf("first_expressions -> epression @ TYPEID . OBJECTID (  )\nlinha: %d\n\n",line_count);}
    
    | expr t_at t_id_type t_dot t_id_obj t_open_par expr t_close_par      {printf("first_expressions -> expression @ TYPEID . OBJECTID ( expression )\nlinha: %d\n\n",line_count);}
    
    | expr t_at t_id_type t_dot t_id_obj t_open_par expr more_expressions t_close_par        {printf("first_expressions -> expression @ TYPEID . OBJECTID ( expression more_expression )\nlinha: %d\n\n",line_count);}
;

more_expressions:
    t_comma expr        {printf("more_expression -> , expression\nlinha: %d\n\n",line_count);}
    |   more_expressions t_comma expr       {printf("more_expression -> more_expressions , expression\nlinha: %d\n\n",line_count);}
;

%%

int main() {
    extern FILE *yyin;
    yyin = fopen("input.txt", "r");
    return yyparse();
}

void yyerror() {
    printf("Erro no parser na linha %d ou proxima a ela.\n token que causou o erro: %d, %s",line_count, yychar,yychar);
}