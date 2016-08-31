/* description: Parses and executes mathematical expressions. */

/* lexical grammar */
%lex

%{
%}

%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"cp"		      return 'T_CP'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%start expressions


%% /* language grammar */

expressions
    : command EOF
        {{ typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }}
    ;

command
    : T_CP NUMBER 
        {chrome.tabs.duplicate(all_tabs[$2].id);}
    ;

