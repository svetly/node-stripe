var express = require('express');


var app = express.createServer();
app.use(express.bodyParser()); //auto populate the body property of request variable

// static files
app.use(express.static(__dirname + '/public'));
app.use(express.bodyParser());
//app.use(express.bodyParser({type: 'hidden'}));
app.use(app.router);


var pay_stripe = require('./pay_stripe.js');
app.use(express.bodyParser());

app.get('/', function(req, res){
  res.render('index.ejs', {title: 'The Grid'});
});

app.get('/plans', function(req, res){
  res.render('plans.ejs', {title: 'The Grid'});
});



// BASIC PLAN
app.get('/plans_basic', function(req, res){
  res.render('plans_basic.ejs', {title: 'Support the Grid'});
});
//post request -> invokes process payment function
app.post('/plans_basic', pay_stripe.process_payment_basic); //access post object



//PRO PLAN
app.get('/plans_pro', function(req, res){
  res.render('plans_pro.ejs', {title: 'Pro Package'});
});
//post request -> invokes process payment function
app.post('/plans_pro', pay_stripe.process_payment_pro); //access post object



//DEVELOPER PLAN
app.get('/plans_developer', function(req, res){
  res.render('plans_developer.ejs', {title: 'Developer Package'});
});
//post request -> invokes process payment function
app.post('/plans_developer', pay_stripe.process_payment_developer); //access post object



//handling all other urls
app.get('/*', function(req, res) {
  res.status(404).render('error.ejs', {title: 'Error'});
});

var PORT = 3000;
app.listen(PORT, function(){
  console.log("Listening on " + PORT)
});

/*var port = process.env.PORT || 3000;
app.listen(port, function() {
  console.log("Listening on " + port);
});
*/