%{
  #include<stdio.h>  
  void yyerror(const char *);
  int yylex();
  FILE *iFile, *oFile;
  extern FILE *yyin;
  int flag=0;
%}
 
%union { double ddouble; 
		int lsym;}
	
%token <ddouble> NUMBER
%token IDENTIFIER

%left '+' '-'
  
%left '*' '/'
  
%left '(' ')'

%right UMINUS

%type <ddouble> expr
  

%%
lines : lines smcl
	  | lines '\n'
	  | 
	  ;
	  
smcl: expr ';' { fprintf(oFile, "%g\n", $1); }
	;
  

expr : expr '+' expr { $$ = $1 + $3; }
  
  | expr '-' expr { $$ = $1 - $3; }
  
  | expr '*' expr { $$ = $1 * $3; }
  
  | expr '/' expr { $$ = $1 / $3; }
  
  | '(' expr ')' { $$ = $2; }  
 
  | '-' expr %prec UMINUS { $$ = -$2; }
 
  | NUMBER {$$ = $1;}
  
  ;
  
%% 
void yyerror(const char *s)
{
   fprintf(oFile, "error\n");   
}

int main()
{
   iFile = fopen("input.txt", "r");
   oFile = fopen("output.txt", "w");
   yyin = iFile;
   printf("nn");  
   
   for(int i=0;i<100;i++)
	yyparse();  
   
   fclose(iFile);
   fclose(oFile); 
   
   return 0;
 
}
  
