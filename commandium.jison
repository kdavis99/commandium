/* description: Parses and executes a language built for web browsing. */

/* lexical grammar */
%lex

%{
   var cal_details = {};
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
[0-9]+("."[0-9]+)?\b  return 'T_NUM_CONST'
"cp"		      return 'T_CP'
"rm"		      return 'T_RM'
"act"		      return 'T_ACTIVE'
"open"		      return 'T_OPEN'
"cal"		      return 'T_CAL'
"title"		      return 'T_TITLE'
"where"		      return 'T_LOCATION'
"desc"	      	      return 'T_DESC'
"when"		      return 'T_WHEN'
"-"		      return 'T_DASH'
"@"		      return 'T_AT'
"/"		      return 'T_SLASH'
";"		      return 'T_SEMIC'
":"		      return 'T_COLON'
"="		      return 'T_EQUAL'
","		      return 'T_COMMA'
"{"		      return 'T_LBRACE'
"}"		      return 'T_RBRACE'
[Pp][Mm]              return 'T_PM'
[Aa][Mm]              return 'T_AM'
[Jj](an)              return 'T_JAN'
[Ff](eb)              return 'T_FEB'
[Mm](ar)              return 'T_MAR'
[Aa](pr)              return 'T_APR'
[Mm](ay)              return 'T_MAY'
[Jj](un)              return 'T_JUN'
[Jj](ul)              return 'T_JUL'
[Aa](ug)              return 'T_AUG'
[Ss](ep)              return 'T_SEP'
[Oo](ct)              return 'T_OCT'
[Nn](ov)              return 'T_NOV'
[Dd](ec)              return 'T_DEC'
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
  | command
  | google_cmds
  ;

google_cmds
  : T_OPEN T_CAL T_LBRACE cal_details T_RBRACE
     {{
	console.log("uh pls");
	console.log(cal_details["text"] + " --- " + cal_details["dates"]);
	var prefix = "https://calendar.google.com/calendar/render?action=TEMPLATE&"
	for (detail in cal_details) {
		prefix = prefix + detail + "=" + cal_details[detail] + "&";
        }
	console.log(prefix);
	chrome.tabs.create({url: prefix});
//	chrome.tabs.create({url: "http://www.google.com/calendar/event?action=TEMPLATE&text=B.B.%20King&dates=20090522T193000/20090524T003000&details=&sprop=website:www.mountainwinery.com&location=The%20Mountain%20Winery,%2014831%20Pierce%20Road,%20Saratoga,%20CA%2095070"});
     }}
  ;

cal_detail
  : T_TITLE T_EQUAL T_STRING_CONST T_SEMIC
    {{
	var str = $3.replace(/ /g, "+");
	str = str.substring(1, str.length - 1);
	cal_details["text"] = str;
    }}
  | T_DESC T_EQUAL T_STRING_CONST T_SEMIC
    {{
	var str = $3.replace(/ /g, "%20");
	console.log($3);
	str = str.substring(1, str.length - 1);
	console.log(str);
	cal_details["details"] = str;
    }}

cal_details
  : cal_details cal_detail
  | cal_detail
  ;

month
  : T_JAN
  | T_FEB
  | T_MAR
  | T_APR
  | T_MAY
  | T_JUN
  | T_JUL
  | T_AUG
  | T_SEP
  | T_OCT
  | T_NOV
  | T_DEC
  ;

date
  : month T_NUM_CONST T_COMMA T_NUM_CONST
    {{
	$$ = ($1 + " " + $2.toString() + ", " + $4.toString());
    }}
  | month T_NUM_CONST
    {{
	$$ = ($1 + " " + $2.toString());
    }}
  ;

time
  : T_NUM_CONST T_COLON T_NUM_CONST period
    {{
	var hour;
	console.log($4);
	if ($4 == "pm" || $4 == "PM") {
	  hour = parseInt($1) + parseInt(12);
        } else {
          hour = $1;
        }
        $$ = (hour.toString() + ":" + $3.toString());
    }}
  ;

period
  : T_AM
  | T_PM
  ;

cal_detail
  : T_TITLE T_EQUAL T_STRING_CONST T_SEMIC
    {{
	var str = $3.replace(/ /g, "+");
	str = str.substring(1, str.length - 1);
	cal_details["text"] = str;
    }}
  | T_LOCATION T_EQUAL T_STRING_CONST T_SEMIC
    {{
	var str = $3.replace(/ /g, "%20");
	str = str.substring(1, str.length - 1);
	cal_details["location"] = str;
    }}
  | T_DESC T_EQUAL T_STRING_CONST T_SEMIC
    {{
	var str = $3.replace(/ /g, "%20");
	console.log($3);
	str = str.substring(1, str.length - 1);
	console.log(str);
	cal_details["details"] = str;
    }}
  | T_WHEN T_EQUAL date T_SEMIC
    {{
	var cur_date = new Date();
 	begin = new Date($3);
	console.log(end + " -- " + begin);
	var year = cur_date.getFullYear();
	var beg_year, beg_month, beg_date, end_date, full_string_date;

	if (begin.getFullYear() == 2001 &&
	     cur_date.getMonth() > begin.getMonth()) {
	   beg_year = (year + 1).toString();
	} else if (begin.getFullYear() == 2001) {
	   beg_year = year;
	} else {
	   beg_year = begin.getFullYear().toString();
	}

	if ((begin.getMonth() + 1).toString().length == 1) {
	  beg_month = "0" + (begin.getMonth() + 1).toString();
	  console.log(beg_date + year);
	} else {
       	  beg_month = (begin.getMonth() + 1).toString();
	  console.log(beg_month + year);
	}

	if (begin.getDate().toString().length == 1) {
	  beg_date = "0" + (begin.getDate()).toString();
	} else {
	  beg_date = begin.getDate().toString();
	}

	if ((begin.getDate() + 1).toString().length == 1) {
	  end_date = "0" + ((begin.getDate() + 1)).toString();
	} else {
	  end_date = (begin.getDate() + 1).toString();
	}

	full_string_date = beg_year + beg_month + beg_date 
                            + "/" + beg_year + beg_month + end_date;
		
	cal_details["dates"] = full_string_date;
    }}
  | T_WHEN T_EQUAL date T_DASH date T_SEMIC
    {{
	var cur_date = new Date();
 	begin = new Date($3);
 	end = new Date($5);
	console.log(end + " -- " + begin);
	var year = cur_date.getFullYear();
	var beg_year, end_year, beg_month, end_month, beg_date, end_date, full_string_date;

	if (begin.getFullYear() == 2001 &&
	     cur_date.getMonth() > begin.getMonth()) {
	   beg_year = (year + 1).toString();
	} else if (begin.getFullYear() == 2001) {
	   beg_year = year;
	} else {
	   beg_year = begin.getFullYear().toString();
	}

	if (end.getFullYear() == 2001 &&
	     cur_date.getMonth() > end.getMonth()) {
	   end_year = (year + 1).toString();
	} else if (end.getFullYear() == 2001) {
	   end_year = year;
	} else {
	   end_year = end.getFullYear().toString();
	}

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

	if ((end.getDate() + 1).toString().length == 1) {
	  end_date = "0" + ((end.getDate() + 1)).toString();
	} else {
	  end_date = (end.getDate() + 1).toString();
	}

	full_string_date = beg_year + beg_month + beg_date 
                            + "/" + end_year + end_month + end_date;
		
	cal_details["dates"] = full_string_date;
    }}	
  | T_WHEN T_EQUAL date T_AT time T_DASH time T_SEMIC
    {{
	var cur_date = new Date();
 	var begin = new Date($3 + " " + $5);
	var end = new Date($3 + " " + $7);
	console.log(begin + " -- " + end);
	var year = cur_date.getFullYear();
	var beg_year, beg_month, beg_date, full_string_date;
	var beg_hours, beg_minutes, end_hours, end_minutes;

	if (begin.getFullYear() == 2001 &&
	     cur_date.getMonth() > begin.getMonth()) {
	   beg_year = (year + 1).toString();
	} else if (begin.getFullYear() == 2001) {
	   beg_year = year;
	} else {
	   beg_year = begin.getFullYear().toString();
	}

	if ((begin.getMonth() + 1).toString().length == 1) {
	  beg_month = "0" + (begin.getMonth() + 1).toString();
	  console.log(beg_date + year);
	} else {
       	  beg_month = (begin.getMonth() + 1).toString();
	  console.log(beg_month + year);
	}

	if (begin.getDate().toString().length == 1) {
	  beg_date = "0" + (begin.getDate()).toString();
	} else {
	  beg_date = begin.getDate().toString();
	}

	if (begin.getHours().toString().length == 1) {
	  beg_hours = "0" + (begin.getHours()).toString();
	} else {
	  beg_hours = begin.getHours().toString();
	}

	if (end.getHours().toString().length == 1) {
	  end_hours = "0" + (end.getHours()).toString();
	} else {
	  end_hours = end.getHours().toString();
	}

	if (begin.getMinutes().toString().length == 1) {
	  beg_minutes = "0" + (begin.getMinutes()).toString();
	} else {
	  beg_minutes = begin.getMinutes().toString();
	}

	if (end.getMinutes().toString().length == 1) {
	  end_minutes = "0" + (end.getMinutes()).toString();
	} else {
	  end_minutes = end.getMinutes().toString();
	}

	full_string_date = beg_year + beg_month + beg_date + "T" + beg_hours + beg_minutes + "00"
                            + "/" + beg_year + beg_month + beg_date + "T" + end_hours + end_minutes + "00";
		
	cal_details["dates"] = full_string_date;
    }}
  | T_WHEN T_EQUAL date T_AT time T_DASH date T_AT time T_SEMIC
    {{
	var cur_date = new Date();
 	begin = new Date($3 + " " + $5);
 	end = new Date($7 + " " + $9);
	console.log(end + " -- " + begin);
	var year = cur_date.getFullYear();
	var beg_year, end_year, beg_month, end_month, beg_date, end_date, full_string_date;
	var beg_hours, end_hours, beg_minutes, end_minutes;

	if (begin.getFullYear() == 2001 &&
	     cur_date.getMonth() > begin.getMonth()) {
	   beg_year = (year + 1).toString();
	} else if (begin.getFullYear() == 2001) {
	   beg_year = year;
	} else {
	   beg_year = begin.getFullYear().toString();
	}

	if (end.getFullYear() == 2001 &&
	     cur_date.getMonth() > end.getMonth()) {
	   end_year = (year + 1).toString();
	} else if (end.getFullYear() == 2001) {
	   end_year = year;
	} else {
	   end_year = end.getFullYear().toString();
	}

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

	if (begin.getHours().toString().length == 1) {
	  beg_hours = "0" + (begin.getHours()).toString();
	} else {
	  beg_hours = begin.getHours().toString();
	}

	if (end.getHours().toString().length == 1) {
	  end_hours = "0" + (end.getHours()).toString();
	} else {
	  end_hours = end.getHours().toString();
	}

	if (begin.getMinutes().toString().length == 1) {
	  beg_minutes = "0" + (begin.getMinutes()).toString();
	} else {
	  beg_minutes = begin.getMinutes().toString();
	}

	if (end.getMinutes().toString().length == 1) {
	  end_minutes = "0" + (end.getMinutes()).toString();
	} else {
	  end_minutes = end.getMinutes().toString();
	}

	full_string_date = beg_year + beg_month + beg_date + "T" + beg_hours + beg_minutes + "00"
                            + "/" + end_year + end_month + end_date + "T" + end_hours + end_minutes + "00";
		
	cal_details["dates"] = full_string_date;
    }}
  ;

command
  : T_CP T_NUM_CONST T_SEMIC 
     {{
	console.log("dupdup" + $2);
	chrome.tabs.duplicate(all_tabs[$2].id);
     }}
  | T_RM T_NUM_CONST T_SEMIC 
     {{
	chrome.tabs.remove(all_tabs[$2].id);
     }}
  | T_ACTIVE T_NUM_CONST T_SEMIC 
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
