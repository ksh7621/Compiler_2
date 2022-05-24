%{  
  #include "test.tab.h" 
  #include <stdio.h>
  #include <stdlib.h>   
  void yyerror(char *);
%}

digit [0-9]
num (0|([1-9]{digit}*))(\.{digit}+)?((E|e)[+\-]?{digit}+)?
delim[ \t]+
whitespace {delim}+
letter[A-Za-z]
op [-+*/()=]
smcl ;
nl \n
id {letter}({letter}|{digit})*
%%

{num} { yylval.ddouble = atof(yytext);
		return NUMBER; 
	}  
{id} { return IDENTIFIER; }
{whitespace} ;
{op} { return *yytext; }
{smcl} {return *yytext;}
{nl} {return *yytext;} 


%%
  
int yywrap()
{
 return 1;
}