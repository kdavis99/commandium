window.onload = function() {

   // (TODO: kylee) - create google calendar event/google doc/etc
   //    Google Calendar: date, time, name of event, description, etc.

   function parse_input() {
      console.log(document.getElementById('user_input').value);
      return commandium.parse(document.getElementById('user_input').value);
   }

   document.getElementById('user').onclick = parse_input;

   // document.getElementById('user').onclick = // get_tabs;
}
/*   chrome.commands.onCommand.addListener(function(command) {
     console.log('Command:', command);
     if (command == "toggle-feature-submit") {
     document.getElementById('user').click();
     }
     });

     function trim(s){ 
     return ( s || '' ).replace( /^\s+|\s+$/g, '' ); 
     }

// function to initialize the array of tabs

var separate_commands = new Array();
function parse_commands() {
var input = document.getElementById('user_input').value;
var input_commands = input.split(";");
for (command in input_commands) {
separate_commands.push(input_commands[command]);
execute_commands(input_commands[command]);
}
}

// function to execute each of the arrays 
function execute_commands(command) {
get_tabs();
var command_by_space = command.split(" ");
console.log(command);

var first = -1, second = -1;
for (str in command_by_space) {
word = trim(command_by_space[str]);
console.log(word);
if (word.includes("/")) {
console.log("/");
var range = word.split("/");
var first = range[0];
var second = range[1];
} else if ((first > -1 && second > -1) && (word == "cp" || word == "rm")) {
console.log("cprrm");
// potential "hacky" solution - however it seemed to be more
// of a bug in chrome.tabs.duplicate
for (i = first - 1; i < second; i++) {
if (all_tabs[i + 1]) {
switch(word) {
case "cp":
console.log("fcp" + (i + 1));
console.log(all_tabs[i+1].id);
chrome.tabs.duplicate(all_tabs[i + 1].id);
break;
case "rm":
console.log("frm");
chrome.tabs.remove(all_tabs[i + 1].id);
break;
}
}
}
} else if (word == "rmcps") {
// remove all tabs with a duplicate title
var count_map = {};
for (tab in all_tabs) {
console.log(all_tabs[tab].title);
if (count_map[all_tabs[tab].title] != 1) {
count_map[all_tabs[tab].title] = 1;
} else {
chrome.tabs.remove(all_tabs[tab].id);
}
}
} else if (/[0-9a-z]/i.test(word)) {
console.log("cprm");
console.log(command_by_space[++str]);
found_num = false;
for (tabs in map_tabs) {
   if (!found_num && map_tabs[tabs] && (map_tabs[tabs].url.includes(word.toLowerCase()) ||
            tabs.includes(word.toLowerCase()) || /[0-9]/.test(word))) {
      switch(command_by_space[str]) {
         case "rm":
            {
               if (/[0-9]/.test(word)) {
                  chrome.tabs.remove(all_tabs[word].id);
                  found_num = true;
               } else {
                  console.log(map_tabs[tabs]);
                  chrome.tabs.remove(map_tabs[tabs].id);
               }
               break;
            }
         case "rr":
            {
               console.log("rr");
               if (/[0-9]/.test(word)) {
                  chrome.tabs.reload(all_tabs[word].id);
                  found_num = true;
               } else {
                  chrome.tabs.reload(map_tabs[tabs].id);
               }
               break;
            }
         case "cp":
            {
               console.log("cp");
               // check if deleting index (number) or title
               if (/[0-9]/.test(word)) {
                  chrome.tabs.duplicate(all_tabs[word].id);
                  found_num = true;
               } else {
                  chrome.tabs.duplicate(map_tabs[tabs].id);
               }
               break;
            }
      }
   }
}
}
}
}*/
