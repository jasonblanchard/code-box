var express = require('express');
var bodyParser = require('body-parser')
var sys = require('sys');
var exec = require('child_process').exec;
var jsesc = require('jsesc');
var child;

var app = express();

app.use(bodyParser.urlencoded({ extended: true }));

app.post('/', function(req, res){
  
  var code = jsesc(JSON.parse(req.body.input).code, {'quotes':'double'}); 
  var code = code.replace(/\'/g, "'\\''");

  var command = 'ruby -e "' + code + '"';
  var safeCommand = "su -m coder -c '" + command + "'";

  var response = {
    exit_status: '0', 
    input: code,
    output: ''
  };

  sys.print("Executing: \n" + code + "\n\n");
  sys.print("Via: " + safeCommand + "\n\n");
  
  child = exec(safeCommand, function (error, stdout, stderr) {
    response.output = stdout

    if (error !== null) {
      response.exit_status = '1';
      response.output = stderr;
    }

    sys.print(JSON.stringify(response));
    res.send(response);
  });
});

app.get('/', function(req, res) {
  res.send('running');
});

app.listen(8081);
