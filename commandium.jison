/* description: Parses and executes mathematical expressions. */

/* lexical grammar */
%lex

%{
   var all_tabs = new Array();
   var map_tabs = {};
   console.log("here");
   chrome.tabs.query({currentWindow: true}, function (arrayOfTabs) {
      for (i = 0; i < arrayOfTabs.length; i++) {
         all_tabs[i] = arrayOfTabs[i];
         // map used for removing duplicate tabs/doing things with
         // the tab by name
         map_tabs[arrayOfTabs[i].id] = arrayOfTabs[i];
      }
      console.log("here please");
      // (TODO: kylee) - only call parse commands on the first call to init.
      // After that, we want the updated tabs that are created from other calls
      // (like duplicate). Needed for: "<name> cp; rmcps;"
   });
%}

%%

\s+                   /* skip whitespace */
\"[^"]*\"	      return 'T_STRING_CONST'
[0-9]+("."[0-9]+)?\b  return 'T_NUM'
"cp"		      return 'T_CP'
";"		      return 'T_SEMIC'
<<EOF>>	 	      return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%start input


%% /* language grammar */

input
    : commands EOF
   {{
      console.log("in");
      // typeof console !== 'undefined' ? console.log($1) : print($1);
      return $1; 
   }}
    ;

commands
    : commands command
    | command
    ;

command
    : T_CP T_NUM T_SEMIC
   {{
      console.log("dupdup" + $2);
      chrome.tabs.duplicate(all_tabs[$2].id);
   }}
    | T_RM T_NUM T_SEMIC
   {{
      chrome.tabs.remove(all_tabs[$2].id);
   }}
    | T_CP T_STRING_CONST T_SEMIC
   {{
      title_substr = $2.substring(1, $2.length - 1);
     for (m_id in map_tabs) {
	 console.log(map_tabs[m_id].url + " -- " + map_tabs[m_id].title + " " +title_substr.toLowerCase());
         if (map_tabs[m_id].url.toLowerCase().includes(title_substr.toLowerCase()) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr.toLowerCase())) {
		// console.log("dups")
                chrome.tabs.duplicate(map_tabs[m_id].id);
         }
      }
   }}
    ;


