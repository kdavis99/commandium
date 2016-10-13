/* description: Parses and executes a language built for web browsing. */

/* lexical grammar */
%lex

%{
   var details = {};
   var all_tabs = new Array();
   var map_tabs = {};
   chrome.tabs.query({currentWindow: true}, function (arrayOfTabs) {
      for (i = 0; i < arrayOfTabs.length; i++) {
	 all_tabs[i] = arrayOfTabs[i];
	 // map used for removing duplicate tabs/doing things with
	 // the tab by name
	 map_tabs[arrayOfTabs[i].id] = arrayOfTabs[i];
      }
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
"rm"		      return 'T_RM'
"act"		      return 'T_ACTIVE'
"open"		      return 'T_OPEN'
"cal"		      return 'T_CAL'
"title"		      return 'T_TITLE'
"date"		      return 'T_DATE'
";"		      return 'T_SEMIC'
"{"		      return 'T_LBRACE'
"}"		      return 'T_RBRACE'
"pls"		      return 'T_PLS'
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
       return $1; 
     }}
  ;

commands
  : commands command
  | google_cmds
    {{
       console.log("google");
    }}
  | command
  ;

google_cmds
  : T_OPEN T_CAL T_LBRACE details T_RBRACE
     {{
	console.log("uh pls");
	console.log(details["text"] + " --- " + details["dates"]);
	var prefix = "https://calendar.google.com/calendar/render?action=TEMPLATE&"
	for (detail in details) {
		prefix = prefix + detail + "=" + details[detail] + "&";
        }
	console.log(prefix);
//	chrome.tabs.create({url: "http://www.google.com/calendar/event?action=TEMPLATE&text=B.B.%20King&dates=20090522T193000/20090524T003000&details=&sprop=website:www.mountainwinery.com&location=The%20Mountain%20Winery,%2014831%20Pierce%20Road,%20Saratoga,%20CA%2095070"});
     }}
  ;

details
  : details detail
  | detail
    {{
	console.log(" detail here ");
    }}
  ;

detail
  : T_TITLE T_STRING_CONST T_SEMIC
    {{
	var str = $2.replace(/ /g, "+");
	str = str.substring(1, $2.length - 1);
	details["text"] = str;
    }}
  | T_DATE T_STRING_CONST T_SEMIC
    {{
	var begin, end, full_string_date;
	if ($2.includes("-")) {
	  var str = $2.replace(/ /g, "");
	  var middle = $2.indexOf("-");
	  console.log("-" + $2.substring(1, middle) + "-");
	  console.log("-" + $2.substring(middle + 1, $2.length - 1) + "-");
	  begin = new Date($2.substring(1, middle));
	  end = new Date($2.substring(middle + 1, $2.length - 1));
	  console.log(begin + " -- " + end);
        }
	  var cur_date = new Date();
	  var year = cur_date.getFullYear();
	  if (cur_date.getMonth().toString() > begin.getMonth().toString()) {
	     year = year + 1;
	  }
	  var beg_month, end_month, beg_date, end_date;
	  if ((begin.getMonth() + 1).toString().length == 1) {
		beg_month = "0" + (begin.getMonth() + 1).toString();
	  	console.log(beg_date + year);
	  } else {
		beg_month = (begin.getMonth() + 1).toString();
	  	console.log(beg_month + year);
	  }

	  if ((end.getMonth() + 1).toString().length == 1) {
		end_month = "0" + (end.getMonth() + 1).toString();
	  } else {
		end_month = (end.getMonth() + 1).toString();
	  }

	  if (begin.getDate().toString().length == 1) {
		beg_date = "0" + (begin.getDate()).toString();
	  } else {
		beg_date = begin.getDate().toString();
	  }

	  if (end.getDate().toString().length == 1) {
		end_date = "0" + (end.getDate()).toString();
	  } else {
		end_date = end.getDate().toString();
	  }

	  full_string_date = year + beg_month + beg_date + "T" + "/" + year + end_month + end_date + "T";
		
	details["dates"] = full_string_date;
    }}
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
  | T_ACTIVE T_NUM T_SEMIC 
     {{
	chrome.tabs.update(all_tabs[$2].id, {active: true});
     }}
  | T_CP T_STRING_CONST T_SEMIC 
     {{
	// removes the double quotes (") from a string const
	title_substr = $2.substring(1, $2.length - 1).toLowerCase();
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.duplicate(map_tabs[m_id].id);
	  }
	}
     }}
  | T_RM T_STRING_CONST T_SEMIC 
     {{
	// removes the double quotes (") from a string const
	title_substr = $2.substring(1, $2.length - 1).toLowerCase();
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.remove(map_tabs[m_id].id);
	  }
	}
     }}
  | T_ACTIVE T_STRING_CONST T_SEMIC
     {{
	// removes the double quotes (") from a string const
	title_substr = $2.substring(1, $2.length - 1).toLowerCase();
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.update(map_tabs[m_id].id, {active: true});
                  break;
	  }
	}
     }}
 | T_CAL T_SEMIC// start_statement_block attributes end_statement_block
     {{
	chrome.tabs.create({url: "http://www.google.com/calendar/event?action=TEMPLATE&text=B.B.%20King&dates=20090522T193000/20090524T003000&details=&sprop=website:www.mountainwinery.com&location=The%20Mountain%20Winery,%2014831%20Pierce%20Road,%20Saratoga,%20CA%2095070"});
    /*{{
      console.log("here");
      var CLIENT_ID = "845539104760-0m42csibtm6949tt5ateme6n76m02n4i.apps.googleusercontent.com";
      var SCOPES = ["https://www.googleapis.com/auth/calendar"];
      function checkAuth() {
        gapi.auth.authorize(
          {
            'client_id': CLIENT_ID,
            'scope': SCOPES.join(' '),
            'immediate': true
          }, handleAuthResult);
      }
      function handleAuthClick(event) {
        gapi.auth.authorize(
          {client_id: CLIENT_ID, scope: SCOPES, immediate: false},
          handleAuthResult);
        return false;
      }
      function handleAuthResult(authResult) {
        var authorizeDiv = document.getElementById('authorize-div');
        if (authResult && !authResult.error) {
          // Hide auth UI, then load client library.
          authorizeDiv.style.display = 'none';
          loadCalendarApi();
        } else {
          // Show auth UI, allowing the user to initiate authorization by
          // clicking authorize button.
          authorizeDiv.style.display = 'inline';
        }
      }*/

/* var head = document.getElementsByTagName('head')[0];
 var script = document.createElement('script');
 script.type = 'text/javascript';
 script.src = "https://apis.google.com/js/client.js?onload=callbackFunction";
 head.appendChild(script);*/
   /* function onLoadFn() {
      console.log("in_log");
      var event = {
        'summary': "Google I/O 2015",
        'location': "800 Howard St., San Francisco, CA 94103",
        'description': "A chance to hear more about Google\'s developer products.",
        'start': {
           'dateTime': "2016-09-28T09:00:00-07:00",
           'timeZone': "America/Los_Angeles"
         },
        'end': {
          'dateTime': "2017-09-28T17:00:00-07:00",
          'timeZone': "America/Los_Angeles"
        },
      };
        var request = gapi.client.calendar.events.insert({
          'calendarId': "primary",
          'resource': event
        });

        request.execute(function(event) {
          appendPre("Event created: " + event.htmlLink);
        });
        handleAuthClick(event);
      }*/
      //gapi.load("calendar", onLoadCal);
      // gapi.load("client,calendar", onLoadFn);
    }}
    ;
