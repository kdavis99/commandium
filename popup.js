window.onload = function() {
  chrome.commands.onCommand.addListener(function(command) {
    console.log('Command:', command);
    if (command == "toggle-feature-submit") {
      document.getElementById('user').click();
    }
  });

  // (TODO: kylee) - create google calendar event/google doc/etc
  //    Google Calendar: date, time, name of event, description, etc.

  function parse_input() {
    console.log(document.getElementById('user_input').value);
    return commandium.parse(document.getElementById('user_input').value);
  }

  document.getElementById('user').onclick = parse_input;
}
