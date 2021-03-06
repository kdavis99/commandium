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
"search"	      return 'T_SEARCH'
"qsearch"	      return 'T_QUOTE_SEARCH'
"ob"		      return 'T_OPEN_BOOKMARK'
"dl"    	      return 'T_DOWNLOAD'
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
[a-zA-Z0-9]+	      return 'T_WORD'
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
     }}
  ;

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
  : T_SEARCH T_EQUAL T_WORD T_DASH T_WORD T_SEMIC
     {{
	// Regular Google search
	start_search = $3;
	end_search = $5;
	// result is an array of the outer html
	chrome.tabs.executeScript({code: "document.documentElement.outerHTML"},
	    function (result) {
	      var prefix = "https://www.google.com/#q=";
	      for (index in result) {
		var words = result[index].split(" ");
		for (word in words) {
		  var word_count = 0;
		  // includes is necessary because sometimes the start_search
		  // is also the beginning of a html div/tag.
                  // i.e. html source = "<i>this is so much fun</i>
                  // var results = ["<i>this", "is", "so", "much", "fun</i>"]
	          if (words[word].includes(start_search)) {
                    prefix = prefix + start_search + "+";
                    word++;
		    while (!words[word].includes(end_search) && word_count <= 11) {
	              prefix = prefix + words[word] + "+";
		      word++;
		      word_count++;
                    }
		    // count the words in between the start word and the end word,
		    // if it is greater than 11, assume it was at the wrong start word
		    // and keep searching
		    if (word_count > 11) {
		      word_count = 0;
		      prefix = "https://www.google.com/#q=";
		    } else {
		      prefix = prefix + end_search;
		      chrome.tabs.create({url: prefix});
                      break;
	            }
	          }
		}
              }
            });
     }}
  | T_QUOTE_SEARCH T_EQUAL T_WORD T_DASH T_WORD T_SEMIC
     {{
	// Google search with quotes around the query
	// result is an array of the outer html
	start_search = $3;
	end_search = $5;
	// retrieve the current tabs html content
	chrome.tabs.executeScript({code: "document.documentElement.outerHTML"},
	    function (result) {
	      var prefix = "https://www.google.com/#q=%22";
	      for (index in result) {
		var words = result[index].split(" ");
		for (word in words) {
		  var word_count = 0;
		  // includes is necessary because sometimes the start_search
		  // is also the beginning of a html div/tag.
                  // i.e. html source = "<i>this is so much fun</i>
                  // var results = ["<i>this", "is", "so", "much", "fun</i>"]
	          if (words[word].includes(start_search)) {
                    prefix = prefix + start_search + "+";
                    word++;
		    while (!words[word].includes(end_search) && word_count <= 11) {
	              prefix = prefix + words[word] + "+";
		      word++;
		      word_count++;
                    }
		    // count the words in between the start word and the end word,
		    // if it is greater than 11, assume it was at the wrong start word
		    // and keep searching
		    if (word_count > 11) {
		      word_count = 0;
		      prefix = "https://www.google.com/#q=%22";
		    } else {
		      prefix = prefix + end_search + "%22";
		      chrome.tabs.create({url: prefix});
	            }
	          }
		}
              }
            });
     }}
  | T_CP T_NUM_CONST T_SEMIC 
     {{
	// $2 represents the index of the tab.
	// tabs are indexed from left to right, and start at 0.
	chrome.tabs.duplicate(all_tabs[$2].id);
     }}
  | T_RM T_NUM_CONST T_SEMIC 
     {{
	// $2 represents the index of the tab.
	// tabs are indexed from left to right, and start at 0.
	chrome.tabs.remove(all_tabs[$2].id);
     }}
  | T_ACTIVE T_NUM_CONST T_SEMIC 
     {{
	// $2 represents the index of the tab.
	// tabs are indexed from left to right, and start at 0.
	chrome.tabs.update(all_tabs[$2].id, {active: true});
     }}
  | T_CP T_WORD T_SEMIC 
     {{
	title_substr = $2.toLowerCase();
	// search through all of the tabs and copy/create duplicates for
	// all of the ones that have a substring that matches the query
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.duplicate(map_tabs[m_id].id);
	  }
	}
     }}
  | T_RM T_WORD T_SEMIC 
     {{
	title_substr = $2.toLowerCase();
	// search through all of the tabs and remove all of the ones that
	// have a substring that matches the query
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.remove(map_tabs[m_id].id);
	  }
	}
     }}
  | T_ACTIVE T_WORD T_SEMIC
     {{
	title_substr = $2.toLowerCase();
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		// make the first match found the current active tab
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.update(map_tabs[m_id].id, {active: true});
                  break;
	  }
	}
     }}
  | T_OPEN_BOOKMARK T_WORD T_SEMIC
     {{
	chrome.bookmarks.search($2, function(results) {
	  // store as a Date variable
	  latest_date = new Date(results[0].dateAdded);
	  // bk for bookmark
	  latest_bk = results[0];
	  for (bookmark in results) {
	    bookmark_date = new Date(results[bookmark].dateAdded);
            // find the most recently created bookmark that matches
	    // the query
	    if (bookmark_date > latest_date) {
	      latest_bk = results[bookmark];
	    }
          }
	  // create the new tab
	  chrome.tabs.create({url: latest_bk.url});
        });
     }}
  | T_OPEN_BOOKMARK T_WORD T_NUM_CONST T_SEMIC
     {{
   	var map_bks = {};
	var map_keys = [];
	chrome.bookmarks.search($2, function(results) {
	  for (bookmark in results) {
	    bookmark_date = new Date(results[bookmark].dateAdded);
	    map_bks[bookmark_date] = results[bookmark];
	  }

	  // create separate array of keys for sorting
	  index = 0;
	  for (key in map_bks) {
	    console.log("key = " + key);
	    map_keys[index] = key;
	    index++;
	  }

	  map_keys.sort();

	  // using the sorted array (map_keys), the most recent dates
	  // are at the end of the array.
	  // open the most recent matching tabs.
      	  for (i = map_keys.length - 1; i > (map_keys.length - $3 - 1); i--) {
	    console.log(i + " = " + map_bks[map_keys[i]].url);
	    chrome.tabs.create({url: map_bks[map_keys[i]].url});
	  }
        });
     }}
  | T_DOWNLOAD T_SEMIC
     {{
         console.log("herrrre");
         chrome.tabs.getSelected(function(tab) {
           console.log("herrrre");
           chrome.downloads.download({url: tab.url});
         });
     }}
   ;
