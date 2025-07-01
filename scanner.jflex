import java_cup.runtime.*;

%%

%class Yylex
%unicode
%cup
%line
%column

%{
    private Symbol sym(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol sym(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

n1 = \n|\r|\n\r
ws = [ \t]

/*
uint = 0 | [1-9][0-9]*
id = [a-zA-Z_][a-zA-Z0-9_]*
hexnum = [0-9a-fA-F]
real = ("+"|"-")? ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | \.[0-9]+ | [1-9][0-9]\. | 0\.)
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?
all = a | A | b | B | c | C | d | D | e | E | f | F
ip = ({ipnum}\.){3}{ipnum}
ipnum = [0-9] | [1-9][0-9] | [1-9][0-9]{2} | 2([0-4][0-9] | 5[0-5])
*/
qstring = \" ~ \"

sep=\+{4}(\+\+)*

bin = 101 | 11[01] | 1[01]{3,5} | 100[01]{4} | 101[01]{3}0 

numb= \-(12[13]|1([01][13579])|[1-9][13579]|[13579])|[13579]|[1-9][13579]
    |[1-9]{2}[13579]|1[0-9]{2}[13579]|2[0-4][0-9][13579]|25([0-5][13579]|6[135])

word="ij"
word1 = "i"
word2 = "j"

tok1=((\!{bin})|(\?{numb}({word}+|{word1}|{word2})?)){end_token}

date=2025\/06\/(1[6-9]|2[0-9]|30) |2025\/0[78]\/(0[1-9]|[1-2][0-9]|3[01]) 
    |2025\/09\/(0[1-9]|[1-2][0-9]|30)|2025\/10\/(0[1-9]|[1-2][0-9]|3[01]) 
    |2025\/11\/(0[1-9]|[1-2][0-9]|30)|2025\/12\/(0[1-9]|[1-2][0-9]|3[01])
    |2026\/01\/(0[1-9]|[1-2][0-9]|3[01])|2026\/02\/(0[1-9]|[1][0-9]|2[0-4])

hour= \: 05 \:(1[89] | [2-5][0-9])| \: 0[6-9]\:[0-5][0-9] |\: 10\:([0-3][0-9] | 4[0-7])

tok2 =(\${date}({hour})?){end_token}

uint = 0 | [1-9][0-9]*


comment = "<++" ~ "++>"|"//".*
end_token   = [ \t]* \;


%%


/*
"sth"			{return sym(sym.STH, new String(yytext()));}

"."				{return sym(sym.DOT);}
","				{return sym(sym.CM);}

":"				{return sym(sym.DD);}
"("				{return sym(sym.RO);}
")"				{return sym(sym.RC);}
"["				{return sym(sym.SO);}
"]"				{return sym(sym.SC);}
"{"				{return sym(sym.GO);}
"}"				{return sym(sym.GC);}
"|"				{return sym(sym.PIPE);}
"="				{return sym(sym.EQ);}
"+"				{return sym(sym.PLUS);}
"-"				{return sym(sym.MINUS);}
"*"				{return sym(sym.STAR);}
"/"				{return sym(sym.DIV);}
"&&"			{return sym(sym.AND);}
"||"			{return sym(sym.OR);}
"!"				{return sym(sym.NOT);}
"=="			{return sym(sym.EQEQ);}
"!="			{return sym(sym.NEQ);}
">"				{return sym(sym.MAJ);}
"<"				{return sym(sym.MIN);}
">="			{return sym(sym.MAJEQ);}
"<="			{return sym(sym.MINEQ);}
"->"			{return sym(sym.ARROW);}
*/

{sep} 			{return sym(sym.SEP);}
{tok1} 			{return sym(sym.TOK1);}
{tok2} 			{return sym(sym.TOK2);}
"obj"			{return sym(sym.OBJ, new String(yytext()));}
"name"			{return sym(sym.NAME, new String(yytext()));}
"end"			{return sym(sym.END, new String(yytext()));}
","				{return sym(sym.CM);}
{qstring}		{return sym(sym.QSTRING, new String(yytext()));}
{uint}			{return sym(sym.UINT, new Integer(yytext()));}
"?"				{return sym(sym.QA);}
"-?"			{return sym(sym.MQA, new String(yytext()));}
"("				{return sym(sym.RO);}
")"				{return sym(sym.RC);}
"-neq"			{return sym(sym.NEQU, new String(yytext()));}
"-eq"			{return sym(sym.EQU, new String(yytext()));}
"."				{return sym(sym.DOT);}
"IS_TRUE"			{return sym(sym.ISTRUE, new String(yytext()));}
"print"			{return sym(sym.PRINT, new String(yytext()));}
"IS_FALSE"			{return sym(sym.ISFALSE, new String(yytext()));}
"AND"				{return sym(sym.AND);}
"OR"				{return sym(sym.OR);}
"NOT"				{return sym(sym.NOT);}
"NAME"			{return sym(sym.NAME, new String(yytext()));}



/*
{id}			{return sym(sym.ID, new String(yytext()));}
{uint}			{return sym(sym.UINT, new Integer(yytext()));}
{real}			{return sym(sym.REAL, new Float(yytext()));}
{double}		{return sym(sym.DOUBLE, new Double(yytext()));}
*/

{comment}		{;}
{n1}|{ws}       {;}

.               {System.out.println("SCANNER ERROR: " + yytext());}
