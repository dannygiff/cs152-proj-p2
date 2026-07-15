    /* cs152-miniL phase2 */
%{
  #include <stdio.h>
  #include <stdlib.h>
  void yyerror(const char *msg);
  extern int currLine;
  extern int currPos;
  FILE * yyin;
%}

%union{
  /* put your types here */
  int num_val;
  char* ident_val;
}

%error-verbose
%locations
%start prog_start
%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY ENUM OF IF THEN ENDIF ELSE FOR WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN
%token <ident_val> IDENT
%token <num_val> NUMBER
%token SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET
%left MULT DIV MOD 
%left ADD SUB
%left LT LTE GT GTE EQ NEQ
%right NOT
%left AND OR
%right ASSIGN  

/* %start program */

%% 

  /* write your rules here */
prog_start: functions {printf("prog_start -> functions\n");}
          ;

functions:   /*empty*/ {printf("functions -> epsilon\n");}
          |  function functions{printf("functions -> function functions\n");}
          ;

function:  {printf("function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY")}
          ;

declarations:   /*empty*/ {printf("declarations -> epsilon\n");}
          |  declaration SEMICOLON declarations {printf("declarations -> declaration SEMICOLON declarations\n");}
          ;

declaration: idents COLON INTEGER {printf("declaration -> idents COLON INTEGER\n");}
          |  idents COLON ENUM L_PAREN idents R_PAREN {printf("declaration -> idents COLON ENUM L_PAREN idents R_PAREN\n");}
          |  idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("declaration -> idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
          ;

idents: IDENT {printf("idents -> IDENT\n");}
          |  IDENT COMMA idents {printf("idents -> IDENT COMMA idents\n");}
          ;

statements: statement SEMICOLON {printf("statements -> statement SEMICOLON\n");}
          |  statement SEMICOLON  statements {printf("statements -> statement SEMICOLON statements\n");}
          ;

statement: state_a {printf("statement -> state_a\n");}
          |  state_b {printf("statement -> state_b\n");}
          |  state_c {printf("statement -> state_c\n");}
          |  state_d {printf("statement -> state_d\n");}
          |  state_e {printf("statement -> state_e\n");}
          |  state_f {printf("statement -> state_f\n");}
          |  state_g {printf("statement -> state_g\n");}
          |  state_h {printf("statement -> state_h\n");}
          ;

bool_exp: relation_and_exp {printf("bool_exp -> relation_and_exp\n");}
          |  relation_and_exp OR bool_exp {printf("bool_exp -> relation_and_exp OR bool_exp\n");}
          ;

relation_and_exp: relation_expr {printf("relation_and_exp -> relation_expr\n");}
          |  relation_expr AND relation_and_exp {printf("relation_and_exp -> relation_expr AND relation_and_exp\n");}
          ;

relation_expr: rel_exp {printf("relation_expr -> rel_exp\n");}
          |  NOT rel_exp {printf("relation_expr -> NOT rel_exp\n");}
          ;

rel_exp: expression comp expression {printf("rel_exp -> expression comp expression\n");}
          |  TRUE {printf("rel_exp -> TRUE\n");}
          |  FALSE {printf("rel_exp -> FALSE\n");}
          |  L_PAREN bool_exp R_PAREN {printf("rel_exp -> L_PAREN bool_exp R_PAREN\n");}
          ;

comp: EQ {printf("comp -> EQ\n");}
          |  NEQ {printf("comp -> NEQ\n");}
          |  LT {printf("comp -> LT\n");}
          |  GT {printf("comp -> GT\n");}
          |  LTE {printf("comp -> LTE\n");}
          |  GTE {printf("comp -> GTE\n");}
          ;

expressions: expression {printf("expressions -> expression\n");}
          |  expression COMMA expressions {printf("expressions -> expression COMMA expressions\n");}
          ;

mult_expr: term {printf("mult_expr -> term\n");}
          |  term MULT mult_expr {printf("mult_expr -> term MULT mult_expr\n");}
          |  term DIV mult_expr {printf("mult_expr -> term DIV mult_expr\n");}
          |  term MOD mult_expr {printf("mult_expr -> term MOD mult_expr\n");}
          ;

term: term_num {printf("term -> term_num\n");}
          |  SUB term_num {printf("term -> SUB term_num\n");}
          |  term_ident {printf("term -> term_ident\n");}
          ;

term_num: var {printf("term_num -> var\n");}
          |  NUMBER {printf("term_num -> NUMBER\n");}
          |  L_PAREN expression R_PAREN {printf("L_PAREN expression R_PAREN\n");}
          ;
%% 

term_ident: IDENT L_PAREN expressions R_PAREN {printf("term_ident -> IDENT L_PAREN expressions R_PAREN\n");}
          |  IDENT L_PAREN R_PAREN {printf("term_ident -> IDENT L_PAREN R_PAREN\n");}
          ;

var: IDENT {printf("var -> IDENT\n");}
          |  IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
          ;
%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
    printf("Error: Line %d, pos %d: %s \n", currLine, currPos, msg);
}