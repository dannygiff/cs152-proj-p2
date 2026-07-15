   /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
   #include "miniL-parser.h"
   int currLine = 1, currPos = 1;
%}

   /* some common rules */
DIGIT    [0-9]
ALPHA    [a-zA-Z]

%%
   /* specific lexer rules in regex */
[ \t]+            {currPos += yyleng;}

"\n"              {currLine++; currPos = 1;}

"function"        {printf("FUNCTION\n"); currPos += yyleng; return FUNCTION;}

"beginparams"        {printf("BEGIN_PARAMS\n"); currPos += yyleng; return BEGIN_PARAMS;}

"endparams"        {printf("END_PARAMS\n"); currPos += yyleng; return END_PARAMS;}

"beginlocals"        {printf("BEGIN_LOCALS\n"); currPos += yyleng; return BEGIN_LOCALS;}

"endlocals"        {printf("END_LOCALS\n"); currPos += yyleng; return END_LOCALS;}

"beginbody"        {printf("BEGIN_BODY\n"); currPos += yyleng; return BEGIN_BODY;}

"endbody"        {printf("END_BODY\n"); currPos += yyleng; return END_BODY;}

"integer"        {printf("INTEGER\n"); currPos += yyleng; return INTEGER;}

"array"        {printf("ARRAY\n"); currPos += yyleng; return ARRAY;}

"enum"        {printf("ENUM\n"); currPos += yyleng; return ENUM;}

"of"        {printf("OF\n"); currPos += yyleng; return OF;}

"if"        {printf("IF\n"); currPos += yyleng; return IF;}

"then"        {printf("THEN\n"); currPos += yyleng; return THEN;}

"endif"        {printf("ENDIF\n"); currPos += yyleng; return ENDIF;}

"else"        {printf("ELSE\n"); currPos += yyleng; return ELSE;}

"for"        {printf("FOR\n"); currPos += yyleng; return FOR;}

"while"        {printf("WHILE\n"); currPos += yyleng; return WHILE;}

"do"        {printf("DO\n"); currPos += yyleng; return DO;}

"beginloop"        {printf("BEGINLOOP\n"); currPos += yyleng; return BEGINLOOP;}

"endloop"        {printf("ENDLOOP\n"); currPos += yyleng; return ENDLOOP;}

"continue"        {printf("CONTINUE\n"); currPos += yyleng; return CONTINUE;}

"read"        {printf("READ\n"); currPos += yyleng; return READ;}

"write"        {printf("WRITE\n"); currPos += yyleng; return WRITE;}

"and"        {printf("AND\n"); currPos += yyleng; return AND;}

"or"        {printf("OR\n"); currPos += yyleng; return OR;}

"not"        {printf("NOT\n"); currPos += yyleng; return NOT;}

"true"        {printf("TRUE\n"); currPos += yyleng; return TRUE;}

"false"        {printf("FALSE\n"); currPos += yyleng; return FALSE;}

"return"        {printf("RETURN\n"); currPos += yyleng; return RETURN;}

"-"        {printf("SUB\n"); currPos += yyleng; return SUB;}

"+"        {printf("ADD\n"); currPos += yyleng; return ADD;}

"*"        {printf("MULT\n"); currPos += yyleng; return MULT;}

"/"        {printf("DIV\n"); currPos += yyleng; return DIV;}

"%"        {printf("MOD\n"); currPos += yyleng; return MOD;}

"=="        {printf("EQ\n"); currPos += yyleng; return EQ;}

"<>"        {printf("NEQ\n"); currPos += yyleng; return NEQ;}

"<"        {printf("LT\n"); currPos += yyleng; return LT;}

">"        {printf("GT\n"); currPos += yyleng; return GT;}

"<="        {printf("LTE\n"); currPos += yyleng; return LTE;}

">="        {printf("GTE\n"); currPos += yyleng; return GTE;}

({DIGIT})+           {printf("NUMBER %s\n", yytext); currPos += yyleng; yylval.num_val=atoi(yytext); return NUMBER;}

({DIGIT}|_)({ALPHA}|{DIGIT}|_)*       {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter \n", currLine, currPos, yytext); exit(0);}

({ALPHA})({ALPHA}|{DIGIT}|_)*_           {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore \n", currLine, currPos, yytext); exit(0);}

{ALPHA}({ALPHA}|{DIGIT}|_)*({ALPHA}|{DIGIT})*      {printf("IDENT %s\n", yytext); currPos += yyleng; yylval.ident_val = strdup(yytext); return IDENT;}

";"         {printf("SEMICOLON\n"); currPos += yyleng; return SEMICOLON;}

":"         {printf("COLON\n"); currPos += yyleng; return COLON;}

","         {printf("COMMA\n"); currPos += yyleng; return COMMA;}

"("         {printf("L_PAREN\n"); currPos += yyleng; return L_PAREN;}

")"         {printf("R_PAREN\n"); currPos += yyleng; return R_PAREN;}

"["         {printf("L_SQUARE_BRACKET\n"); currPos += yyleng; return L_SQUARE_BRACKET;}

"]"         {printf("R_SQUARE_BRACKET\n"); currPos += yyleng; return R_SQUARE_BRACKET;}

":="         {printf("ASSIGN\n"); currPos += yyleng; return ASSIGN;}

##.+         { /* printf("COMMENT %s\n", yytext); currPos += yyleng; */ }

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%
	/* C functions used in lexer */
