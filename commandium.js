/* parser generated by jison 0.4.17 */
/*
  Returns a Parser object of the following structure:

  Parser: {
    yy: {}
  }

  Parser.prototype: {
    yy: {},
    trace: function(),
    symbols_: {associative list: name ==> number},
    terminals_: {associative list: number ==> name},
    productions_: [...],
    performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate, $$, _$),
    table: [...],
    defaultActions: {...},
    parseError: function(str, hash),
    parse: function(input),

    lexer: {
        EOF: 1,
        parseError: function(str, hash),
        setInput: function(input),
        input: function(),
        unput: function(str),
        more: function(),
        less: function(n),
        pastInput: function(),
        upcomingInput: function(),
        showPosition: function(),
        test_match: function(regex_match_array, rule_index),
        next: function(),
        lex: function(),
        begin: function(condition),
        popState: function(),
        _currentRules: function(),
        topState: function(),
        pushState: function(condition),

        options: {
            ranges: boolean           (optional: true ==> token location info will include a .range[] member)
            flex: boolean             (optional: true ==> flex-like lexing behaviour where the rules are tested exhaustively to find the longest match)
            backtrack_lexer: boolean  (optional: true ==> lexer regexes are tested in order and for each matching regex the action code is invoked; the lexer terminates the scan when a token is returned by the action code)
        },

        performAction: function(yy, yy_, $avoiding_name_collisions, YY_START),
        rules: [...],
        conditions: {associative list: name ==> set},
    }
  }


  token location info (@$, _$, etc.): {
    first_line: n,
    last_line: n,
    first_column: n,
    last_column: n,
    range: [start_number, end_number]       (where the numbers are indexes into the input string, regular zero-based)
  }


  the parseError function receives a 'hash' object with these members for lexer and parser errors: {
    text:        (matched text)
    token:       (the produced terminal token, if any)
    line:        (yylineno)
  }
  while parser (grammar) errors will also provide these members, i.e. parser errors deliver a superset of attributes: {
    loc:         (yylloc)
    expected:    (string describing the set of expected tokens)
    recoverable: (boolean: TRUE when the parser has a error recovery rule available for this particular error)
  }
*/
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
var commandium = (function(){
var o=function(k,v,o,l){for(o=o||{},l=k.length;l--;o[k[l]]=v);return o},$V0=[1,9],$V1=[1,5],$V2=[1,6],$V3=[1,7],$V4=[1,8],$V5=[5,9,44,45,46,47],$V6=[1,32],$V7=[1,33],$V8=[1,34],$V9=[1,35],$Va=[12,35,39,40,41],$Vb=[1,47],$Vc=[1,48],$Vd=[1,49],$Ve=[1,50],$Vf=[1,51],$Vg=[1,52],$Vh=[1,53],$Vi=[1,54],$Vj=[1,55],$Vk=[1,56],$Vl=[1,57],$Vm=[1,58],$Vn=[1,68],$Vo=[38,42,43],$Vp=[38,42];
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"input":3,"commands":4,"EOF":5,"command":6,"google_cmds":7,"T_OPEN":8,"T_CAL":9,"T_LBRACE":10,"cal_details":11,"T_RBRACE":12,"cal_detail":13,"month":14,"T_JAN":15,"T_FEB":16,"T_MAR":17,"T_APR":18,"T_MAY":19,"T_JUN":20,"T_JUL":21,"T_AUG":22,"T_SEP":23,"T_OCT":24,"T_NOV":25,"T_DEC":26,"date":27,"T_NUM_CONST":28,"T_COMMA":29,"time":30,"T_COLON":31,"period":32,"T_AM":33,"T_PM":34,"T_TITLE":35,"T_EQUAL":36,"T_STRING_CONST":37,"T_SEMIC":38,"T_LOCATION":39,"T_DESC":40,"T_WHEN":41,"T_DASH":42,"T_AT":43,"T_PAGE":44,"T_CP":45,"T_RM":46,"T_ACTIVE":47,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",8:"T_OPEN",9:"T_CAL",10:"T_LBRACE",12:"T_RBRACE",15:"T_JAN",16:"T_FEB",17:"T_MAR",18:"T_APR",19:"T_MAY",20:"T_JUN",21:"T_JUL",22:"T_AUG",23:"T_SEP",24:"T_OCT",25:"T_NOV",26:"T_DEC",28:"T_NUM_CONST",29:"T_COMMA",31:"T_COLON",33:"T_AM",34:"T_PM",35:"T_TITLE",36:"T_EQUAL",37:"T_STRING_CONST",38:"T_SEMIC",39:"T_LOCATION",40:"T_DESC",41:"T_WHEN",42:"T_DASH",43:"T_AT",44:"T_PAGE",45:"T_CP",46:"T_RM",47:"T_ACTIVE"},
productions_: [0,[3,2],[4,2],[4,1],[4,1],[7,5],[11,2],[11,1],[14,1],[14,1],[14,1],[14,1],[14,1],[14,1],[14,1],[14,1],[14,1],[14,1],[14,1],[14,1],[27,4],[27,2],[30,4],[32,1],[32,1],[13,4],[13,4],[13,4],[13,4],[13,6],[13,8],[13,10],[6,3],[6,3],[6,3],[6,3],[6,3],[6,3],[6,3],[6,2]],
performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate /* action[1] */, $$ /* vstack */, _$ /* lstack */) {
/* this == yyval */

var $0 = $$.length - 1;
switch (yystate) {
case 1:

       console.log("in");
       return $$[$0-1]; 
     
break;
case 5:

	console.log("uh pls");
	console.log(cal_details["text"] + " --- " + cal_details["dates"]);
	var prefix = "https://calendar.google.com/calendar/render?action=TEMPLATE&"
	for (detail in cal_details) {
		prefix = prefix + detail + "=" + cal_details[detail] + "&";
        }
	console.log(prefix);
	chrome.tabs.create({url: prefix});
//	chrome.tabs.create({url: "http://www.google.com/calendar/event?action=TEMPLATE&text=B.B.%20King&dates=20090522T193000/20090524T003000&details=&sprop=website:www.mountainwinery.com&location=The%20Mountain%20Winery,%2014831%20Pierce%20Road,%20Saratoga,%20CA%2095070"});
     
break;
case 20:

	this.$ = ($$[$0-3] + " " + $$[$0-2].toString() + ", " + $$[$0].toString());
    
break;
case 21:

	this.$ = ($$[$0-1] + " " + $$[$0].toString());
    
break;
case 22:

	var hour;
	console.log($$[$0]);
	if ($$[$0] == "pm" || $$[$0] == "PM") {
	  hour = parseInt($$[$0-3]) + parseInt(12);
        } else {
          hour = $$[$0-3];
        }
        this.$ = (hour.toString() + ":" + $$[$0-1].toString());
    
break;
case 25:

	var str = $$[$0-1].replace(/ /g, "+");
	str = str.substring(1, str.length - 1);
	cal_details["text"] = str;
    
break;
case 26:

	var str = $$[$0-1].replace(/ /g, "%20");
	str = str.substring(1, str.length - 1);
	cal_details["location"] = str;
    
break;
case 27:

	var str = $$[$0-1].replace(/ /g, "%20");
	console.log($$[$0-1]);
	str = str.substring(1, str.length - 1);
	console.log(str);
	cal_details["details"] = str;
    
break;
case 28:

	var cur_date = new Date();
 	begin = new Date($$[$0-1]);
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
    
break;
case 29:

	var cur_date = new Date();
 	begin = new Date($$[$0-3]);
 	end = new Date($$[$0-1]);
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
    
break;
case 30:

	var cur_date = new Date();
 	var begin = new Date($$[$0-5] + " " + $$[$0-3]);
	var end = new Date($$[$0-5] + " " + $$[$0-1]);
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
    
break;
case 31:

	var cur_date = new Date();
 	begin = new Date($$[$0-7] + " " + $$[$0-5]);
 	end = new Date($$[$0-3] + " " + $$[$0-1]);
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
    
break;
case 32:

	console.log("here");
	console.log("before");
	console.log(all_tabs[$$[$0-1]].id);
	console.log(document.documentElement.innerHTML);
	chrome.tabs.executeScript(all_tabs[$$[$0-1]].id, {code: "document.documentElement.outerHTML"},
		function (result) {
		   var prefix = "https://www.google.com/#q=";
		   for (index in result) {
		      var words = result[index].split(" ");
		      for (word in words) {
		         var word_count = 0;
	                 if (words[word] == "recognition") {
			    while (words[word] != "human" && word_count <= 11) {
			       prefix = prefix + words[word] + "+";
			       word++;
			       word_count++;
			    }
			    if (word_count > 11) {
			       word_count = 0;
			       prefix = "https://www.google.com/#q=";
		            } else {
			      prefix = prefix + words[word];
			      chrome.tabs.create({url: prefix});
			    }
	                 }
		      }
                   }
	           //chrome.tabs.create({url: prefix});
		});
     
break;
case 33:

	console.log("dupdup" + $$[$0-1]);
	chrome.tabs.duplicate(all_tabs[$$[$0-1]].id);
     
break;
case 34:

	chrome.tabs.remove(all_tabs[$$[$0-1]].id);
     
break;
case 35:

	chrome.tabs.update(all_tabs[$$[$0-1]].id, {active: true});
     
break;
case 36:

	// removes the double quotes (") from a string const
	title_substr = $$[$0-1].substring(1, $$[$0-1].length - 1).toLowerCase();
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.duplicate(map_tabs[m_id].id);
	  }
	}
     
break;
case 37:

	// removes the double quotes (") from a string const
	title_substr = $$[$0-1].substring(1, $$[$0-1].length - 1).toLowerCase();
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.remove(map_tabs[m_id].id);
	  }
	}
     
break;
case 38:

	// removes the double quotes (") from a string const
	title_substr = $$[$0-1].substring(1, $$[$0-1].length - 1).toLowerCase();
	for (m_id in map_tabs) {
	  if (map_tabs[m_id].url.toLowerCase().includes(title_substr) || 
		map_tabs[m_id].title.toLowerCase().includes(title_substr)) {
		  chrome.tabs.update(map_tabs[m_id].id, {active: true});
                  break;
	  }
	}
     
break;
case 39:

	chrome.tabs.create({url: "http://www.google.com/calendar/event?action=TEMPLATE&text=B.B.%20King&dates=20090522T193000/20090524T003000&details=&sprop=website:www.mountainwinery.com&location=The%20Mountain%20Winery,%2014831%20Pierce%20Road,%20Saratoga,%20CA%2095070"});
    
break;
}
},
table: [{3:1,4:2,6:3,7:4,8:[1,10],9:$V0,44:$V1,45:$V2,46:$V3,47:$V4},{1:[3]},{5:[1,11],6:12,9:$V0,44:$V1,45:$V2,46:$V3,47:$V4},o($V5,[2,3]),o($V5,[2,4]),{28:[1,13]},{28:[1,14],37:[1,15]},{28:[1,16],37:[1,17]},{28:[1,18],37:[1,19]},{38:[1,20]},{9:[1,21]},{1:[2,1]},o($V5,[2,2]),{38:[1,22]},{38:[1,23]},{38:[1,24]},{38:[1,25]},{38:[1,26]},{38:[1,27]},{38:[1,28]},o($V5,[2,39]),{10:[1,29]},o($V5,[2,32]),o($V5,[2,33]),o($V5,[2,36]),o($V5,[2,34]),o($V5,[2,37]),o($V5,[2,35]),o($V5,[2,38]),{11:30,13:31,35:$V6,39:$V7,40:$V8,41:$V9},{12:[1,36],13:37,35:$V6,39:$V7,40:$V8,41:$V9},o($Va,[2,7]),{36:[1,38]},{36:[1,39]},{36:[1,40]},{36:[1,41]},o($V5,[2,5]),o($Va,[2,6]),{37:[1,42]},{37:[1,43]},{37:[1,44]},{14:46,15:$Vb,16:$Vc,17:$Vd,18:$Ve,19:$Vf,20:$Vg,21:$Vh,22:$Vi,23:$Vj,24:$Vk,25:$Vl,26:$Vm,27:45},{38:[1,59]},{38:[1,60]},{38:[1,61]},{38:[1,62],42:[1,63],43:[1,64]},{28:[1,65]},{28:[2,8]},{28:[2,9]},{28:[2,10]},{28:[2,11]},{28:[2,12]},{28:[2,13]},{28:[2,14]},{28:[2,15]},{28:[2,16]},{28:[2,17]},{28:[2,18]},{28:[2,19]},o($Va,[2,25]),o($Va,[2,26]),o($Va,[2,27]),o($Va,[2,28]),{14:46,15:$Vb,16:$Vc,17:$Vd,18:$Ve,19:$Vf,20:$Vg,21:$Vh,22:$Vi,23:$Vj,24:$Vk,25:$Vl,26:$Vm,27:66},{28:$Vn,30:67},o($Vo,[2,21],{29:[1,69]}),{38:[1,70]},{42:[1,71]},{31:[1,72]},{28:[1,73]},o($Va,[2,29]),{14:46,15:$Vb,16:$Vc,17:$Vd,18:$Ve,19:$Vf,20:$Vg,21:$Vh,22:$Vi,23:$Vj,24:$Vk,25:$Vl,26:$Vm,27:75,28:$Vn,30:74},{28:[1,76]},o($Vo,[2,20]),{38:[1,77]},{43:[1,78]},{32:79,33:[1,80],34:[1,81]},o($Va,[2,30]),{28:$Vn,30:82},o($Vp,[2,22]),o($Vp,[2,23]),o($Vp,[2,24]),{38:[1,83]},o($Va,[2,31])],
defaultActions: {11:[2,1],47:[2,8],48:[2,9],49:[2,10],50:[2,11],51:[2,12],52:[2,13],53:[2,14],54:[2,15],55:[2,16],56:[2,17],57:[2,18],58:[2,19]},
parseError: function parseError(str, hash) {
    if (hash.recoverable) {
        this.trace(str);
    } else {
        function _parseError (msg, hash) {
            this.message = msg;
            this.hash = hash;
        }
        _parseError.prototype = Error;

        throw new _parseError(str, hash);
    }
},
parse: function parse(input) {
    var self = this, stack = [0], tstack = [], vstack = [null], lstack = [], table = this.table, yytext = '', yylineno = 0, yyleng = 0, recovering = 0, TERROR = 2, EOF = 1;
    var args = lstack.slice.call(arguments, 1);
    var lexer = Object.create(this.lexer);
    var sharedState = { yy: {} };
    for (var k in this.yy) {
        if (Object.prototype.hasOwnProperty.call(this.yy, k)) {
            sharedState.yy[k] = this.yy[k];
        }
    }
    lexer.setInput(input, sharedState.yy);
    sharedState.yy.lexer = lexer;
    sharedState.yy.parser = this;
    if (typeof lexer.yylloc == 'undefined') {
        lexer.yylloc = {};
    }
    var yyloc = lexer.yylloc;
    lstack.push(yyloc);
    var ranges = lexer.options && lexer.options.ranges;
    if (typeof sharedState.yy.parseError === 'function') {
        this.parseError = sharedState.yy.parseError;
    } else {
        this.parseError = Object.getPrototypeOf(this).parseError;
    }
    function popStack(n) {
        stack.length = stack.length - 2 * n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }
    _token_stack:
        var lex = function () {
            var token;
            token = lexer.lex() || EOF;
            if (typeof token !== 'number') {
                token = self.symbols_[token] || token;
            }
            return token;
        };
    var symbol, preErrorSymbol, state, action, a, r, yyval = {}, p, len, newState, expected;
    while (true) {
        state = stack[stack.length - 1];
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol === null || typeof symbol == 'undefined') {
                symbol = lex();
            }
            action = table[state] && table[state][symbol];
        }
                    if (typeof action === 'undefined' || !action.length || !action[0]) {
                var errStr = '';
                expected = [];
                for (p in table[state]) {
                    if (this.terminals_[p] && p > TERROR) {
                        expected.push('\'' + this.terminals_[p] + '\'');
                    }
                }
                if (lexer.showPosition) {
                    errStr = 'Parse error on line ' + (yylineno + 1) + ':\n' + lexer.showPosition() + '\nExpecting ' + expected.join(', ') + ', got \'' + (this.terminals_[symbol] || symbol) + '\'';
                } else {
                    errStr = 'Parse error on line ' + (yylineno + 1) + ': Unexpected ' + (symbol == EOF ? 'end of input' : '\'' + (this.terminals_[symbol] || symbol) + '\'');
                }
                this.parseError(errStr, {
                    text: lexer.match,
                    token: this.terminals_[symbol] || symbol,
                    line: lexer.yylineno,
                    loc: yyloc,
                    expected: expected
                });
            }
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error('Parse Error: multiple actions possible at state: ' + state + ', token: ' + symbol);
        }
        switch (action[0]) {
        case 1:
            stack.push(symbol);
            vstack.push(lexer.yytext);
            lstack.push(lexer.yylloc);
            stack.push(action[1]);
            symbol = null;
            if (!preErrorSymbol) {
                yyleng = lexer.yyleng;
                yytext = lexer.yytext;
                yylineno = lexer.yylineno;
                yyloc = lexer.yylloc;
                if (recovering > 0) {
                    recovering--;
                }
            } else {
                symbol = preErrorSymbol;
                preErrorSymbol = null;
            }
            break;
        case 2:
            len = this.productions_[action[1]][1];
            yyval.$ = vstack[vstack.length - len];
            yyval._$ = {
                first_line: lstack[lstack.length - (len || 1)].first_line,
                last_line: lstack[lstack.length - 1].last_line,
                first_column: lstack[lstack.length - (len || 1)].first_column,
                last_column: lstack[lstack.length - 1].last_column
            };
            if (ranges) {
                yyval._$.range = [
                    lstack[lstack.length - (len || 1)].range[0],
                    lstack[lstack.length - 1].range[1]
                ];
            }
            r = this.performAction.apply(yyval, [
                yytext,
                yyleng,
                yylineno,
                sharedState.yy,
                action[1],
                vstack,
                lstack
            ].concat(args));
            if (typeof r !== 'undefined') {
                return r;
            }
            if (len) {
                stack = stack.slice(0, -1 * len * 2);
                vstack = vstack.slice(0, -1 * len);
                lstack = lstack.slice(0, -1 * len);
            }
            stack.push(this.productions_[action[1]][0]);
            vstack.push(yyval.$);
            lstack.push(yyval._$);
            newState = table[stack[stack.length - 2]][stack[stack.length - 1]];
            stack.push(newState);
            break;
        case 3:
            return true;
        }
    }
    return true;
}};
/* generated by jison-lex 0.3.4 */
var lexer = (function(){
var lexer = ({

EOF:1,

parseError:function parseError(str, hash) {
        if (this.yy.parser) {
            this.yy.parser.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },

// resets the lexer, sets new input
setInput:function (input, yy) {
        this.yy = yy || this.yy || {};
        this._input = input;
        this._more = this._backtrack = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {
            first_line: 1,
            first_column: 0,
            last_line: 1,
            last_column: 0
        };
        if (this.options.ranges) {
            this.yylloc.range = [0,0];
        }
        this.offset = 0;
        return this;
    },

// consumes and returns one char from the input
input:function () {
        var ch = this._input[0];
        this.yytext += ch;
        this.yyleng++;
        this.offset++;
        this.match += ch;
        this.matched += ch;
        var lines = ch.match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno++;
            this.yylloc.last_line++;
        } else {
            this.yylloc.last_column++;
        }
        if (this.options.ranges) {
            this.yylloc.range[1]++;
        }

        this._input = this._input.slice(1);
        return ch;
    },

// unshifts one char (or a string) into the input
unput:function (ch) {
        var len = ch.length;
        var lines = ch.split(/(?:\r\n?|\n)/g);

        this._input = ch + this._input;
        this.yytext = this.yytext.substr(0, this.yytext.length - len);
        //this.yyleng -= len;
        this.offset -= len;
        var oldLines = this.match.split(/(?:\r\n?|\n)/g);
        this.match = this.match.substr(0, this.match.length - 1);
        this.matched = this.matched.substr(0, this.matched.length - 1);

        if (lines.length - 1) {
            this.yylineno -= lines.length - 1;
        }
        var r = this.yylloc.range;

        this.yylloc = {
            first_line: this.yylloc.first_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.first_column,
            last_column: lines ?
                (lines.length === oldLines.length ? this.yylloc.first_column : 0)
                 + oldLines[oldLines.length - lines.length].length - lines[0].length :
              this.yylloc.first_column - len
        };

        if (this.options.ranges) {
            this.yylloc.range = [r[0], r[0] + this.yyleng - len];
        }
        this.yyleng = this.yytext.length;
        return this;
    },

// When called from action, caches matched text and appends it on next action
more:function () {
        this._more = true;
        return this;
    },

// When called from action, signals the lexer that this rule fails to match the input, so the next matching rule (regex) should be tested instead.
reject:function () {
        if (this.options.backtrack_lexer) {
            this._backtrack = true;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. You can only invoke reject() in the lexer when the lexer is of the backtracking persuasion (options.backtrack_lexer = true).\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });

        }
        return this;
    },

// retain first n characters of the match
less:function (n) {
        this.unput(this.match.slice(n));
    },

// displays already matched input, i.e. for error messages
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },

// displays upcoming input, i.e. for error messages
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20) + (next.length > 20 ? '...' : '')).replace(/\n/g, "");
    },

// displays the character position where the lexing error occurred, i.e. for error messages
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c + "^";
    },

// test the lexed token: return FALSE when not a match, otherwise return token
test_match:function (match, indexed_rule) {
        var token,
            lines,
            backup;

        if (this.options.backtrack_lexer) {
            // save context
            backup = {
                yylineno: this.yylineno,
                yylloc: {
                    first_line: this.yylloc.first_line,
                    last_line: this.last_line,
                    first_column: this.yylloc.first_column,
                    last_column: this.yylloc.last_column
                },
                yytext: this.yytext,
                match: this.match,
                matches: this.matches,
                matched: this.matched,
                yyleng: this.yyleng,
                offset: this.offset,
                _more: this._more,
                _input: this._input,
                yy: this.yy,
                conditionStack: this.conditionStack.slice(0),
                done: this.done
            };
            if (this.options.ranges) {
                backup.yylloc.range = this.yylloc.range.slice(0);
            }
        }

        lines = match[0].match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno += lines.length;
        }
        this.yylloc = {
            first_line: this.yylloc.last_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.last_column,
            last_column: lines ?
                         lines[lines.length - 1].length - lines[lines.length - 1].match(/\r?\n?/)[0].length :
                         this.yylloc.last_column + match[0].length
        };
        this.yytext += match[0];
        this.match += match[0];
        this.matches = match;
        this.yyleng = this.yytext.length;
        if (this.options.ranges) {
            this.yylloc.range = [this.offset, this.offset += this.yyleng];
        }
        this._more = false;
        this._backtrack = false;
        this._input = this._input.slice(match[0].length);
        this.matched += match[0];
        token = this.performAction.call(this, this.yy, this, indexed_rule, this.conditionStack[this.conditionStack.length - 1]);
        if (this.done && this._input) {
            this.done = false;
        }
        if (token) {
            return token;
        } else if (this._backtrack) {
            // recover context
            for (var k in backup) {
                this[k] = backup[k];
            }
            return false; // rule action called reject() implying the next rule should be tested instead.
        }
        return false;
    },

// return next match in input
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) {
            this.done = true;
        }

        var token,
            match,
            tempMatch,
            index;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i = 0; i < rules.length; i++) {
            tempMatch = this._input.match(this.rules[rules[i]]);
            if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
                match = tempMatch;
                index = i;
                if (this.options.backtrack_lexer) {
                    token = this.test_match(tempMatch, rules[i]);
                    if (token !== false) {
                        return token;
                    } else if (this._backtrack) {
                        match = false;
                        continue; // rule action called reject() implying a rule MISmatch.
                    } else {
                        // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
                        return false;
                    }
                } else if (!this.options.flex) {
                    break;
                }
            }
        }
        if (match) {
            token = this.test_match(match, rules[index]);
            if (token !== false) {
                return token;
            }
            // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
            return false;
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. Unrecognized text.\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });
        }
    },

// return next match that has a token
lex:function lex() {
        var r = this.next();
        if (r) {
            return r;
        } else {
            return this.lex();
        }
    },

// activates a new lexer condition state (pushes the new lexer condition state onto the condition stack)
begin:function begin(condition) {
        this.conditionStack.push(condition);
    },

// pop the previously active lexer condition state off the condition stack
popState:function popState() {
        var n = this.conditionStack.length - 1;
        if (n > 0) {
            return this.conditionStack.pop();
        } else {
            return this.conditionStack[0];
        }
    },

// produce the lexer rule set which is active for the currently active lexer condition state
_currentRules:function _currentRules() {
        if (this.conditionStack.length && this.conditionStack[this.conditionStack.length - 1]) {
            return this.conditions[this.conditionStack[this.conditionStack.length - 1]].rules;
        } else {
            return this.conditions["INITIAL"].rules;
        }
    },

// return the currently active lexer condition state; when an index argument is provided it produces the N-th previous condition state, if available
topState:function topState(n) {
        n = this.conditionStack.length - 1 - Math.abs(n || 0);
        if (n >= 0) {
            return this.conditionStack[n];
        } else {
            return "INITIAL";
        }
    },

// alias for begin(condition)
pushState:function pushState(condition) {
        this.begin(condition);
    },

// return the number of states currently on the stack
stateStackSize:function stateStackSize() {
        return this.conditionStack.length;
    },
options: {},
performAction: function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {
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

var YYSTATE=YY_START;
switch($avoiding_name_collisions) {
case 0:/* skip whitespace */
break;
case 1:return 37
break;
case 2:return 28
break;
case 3:return 45
break;
case 4:return 46
break;
case 5:return 47
break;
case 6:return 8
break;
case 7:return 9
break;
case 8:return 35
break;
case 9:return 39
break;
case 10:return 40
break;
case 11:return 41
break;
case 12:return 44
break;
case 13:return 42
break;
case 14:return 43
break;
case 15:return 'T_SLASH'
break;
case 16:return 38
break;
case 17:return 31
break;
case 18:return 36
break;
case 19:return 29
break;
case 20:return 10
break;
case 21:return 12
break;
case 22:return 34
break;
case 23:return 33
break;
case 24:return 15
break;
case 25:return 16
break;
case 26:return 17
break;
case 27:return 18
break;
case 28:return 19
break;
case 29:return 20
break;
case 30:return 21
break;
case 31:return 22
break;
case 32:return 23
break;
case 33:return 24
break;
case 34:return 25
break;
case 35:return 26
break;
case 36:return 'T_PLS'
break;
case 37:return 5
break;
case 38:return 'INVALID'
break;
}
},
rules: [/^(?:\s+)/,/^(?:"[^"]*")/,/^(?:[0-9]+(\.[0-9]+)?\b)/,/^(?:cp\b)/,/^(?:rm\b)/,/^(?:act\b)/,/^(?:open\b)/,/^(?:cal\b)/,/^(?:title\b)/,/^(?:where\b)/,/^(?:desc\b)/,/^(?:when\b)/,/^(?:page\b)/,/^(?:-)/,/^(?:@)/,/^(?:\/)/,/^(?:;)/,/^(?::)/,/^(?:=)/,/^(?:,)/,/^(?:\{)/,/^(?:\})/,/^(?:[Pp][Mm])/,/^(?:[Aa][Mm])/,/^(?:[Jj](an))/,/^(?:[Ff](eb))/,/^(?:[Mm](ar))/,/^(?:[Aa](pr))/,/^(?:[Mm](ay))/,/^(?:[Jj](un))/,/^(?:[Jj](ul))/,/^(?:[Aa](ug))/,/^(?:[Ss](ep))/,/^(?:[Oo](ct))/,/^(?:[Nn](ov))/,/^(?:[Dd](ec))/,/^(?:pls\b)/,/^(?:$)/,/^(?:.)/],
conditions: {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38],"inclusive":true}}
});
return lexer;
})();
parser.lexer = lexer;
function Parser () {
  this.yy = {};
}
Parser.prototype = parser;parser.Parser = Parser;
return new Parser;
})();


if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = commandium;
exports.Parser = commandium.Parser;
exports.parse = function () { return commandium.parse.apply(commandium, arguments); };
exports.main = function commonjsMain(args) {
    if (!args[1]) {
        console.log('Usage: '+args[0]+' FILE');
        process.exit(1);
    }
    var source = require('fs').readFileSync(require('path').normalize(args[1]), "utf8");
    return exports.parser.parse(source);
};
if (typeof module !== 'undefined' && require.main === module) {
  exports.main(process.argv.slice(1));
}
}
