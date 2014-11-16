var express = require('express');
var bodyParser = require('body-parser')
var sys = require('sys');
var exec = require('child_process').exec;
var child;

var app = express();

app.use(bodyParser.urlencoded({ extended: true }));

app.post('/', function(req, res){
  
  var response = {status: 'OK', output: ''};

  var code = req.body.code;
  sys.print("Executing: \n" + code + "\n\n");

  // TODO: Run this as a non-priviledged user with limited access to filesystem
  child = exec("ruby -e '" + code + "'", function (error, stdout, stderr) {
    response.output = stdout;

    if (error !== null) {
      response.status = 'ERROR';
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
