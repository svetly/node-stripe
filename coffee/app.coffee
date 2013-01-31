express = require("express")
app = express.createServer()

# static files
app.use express.static(__dirname + "/public")
app.use express.bodyParser() #auto populate the body property of request variable
app.use app.router
pay_stripe = require("./pay_stripe.js")
app.use express.bodyParser()
app.get "/", (req, res) ->
  res.render "index.ejs",
    title: "The Grid"


app.get "/plans", (req, res) ->
  res.render "plans.ejs",
    title: "The Grid"



# BASIC PLAN
app.get "/order_basic", (req, res) ->
  res.render "order_basic.ejs",
    title: "Support the Grid"
    amount: 20



#post request -> invokes process payment function
app.post "/order_basic", pay_stripe.process_payment_basic #access post object

#PRO PLAN
app.get "/plans_pro", (req, res) ->
  res.render "plans_pro.ejs",
    title: "Pro Package"



#post request -> invokes process payment function
app.post "/plans_pro", pay_stripe.process_payment_pro #access post object

#DEVELOPER PLAN
app.get "/plans_developer", (req, res) ->
  res.render "plans_developer.ejs",
    title: "Developer Package"



#post request -> invokes process payment function
app.post "/plans_developer", pay_stripe.process_payment_developer #access post object

#handling all other urls
app.get "/*", (req, res) ->
  res.status(404).render "error.ejs",
    title: "Error"


PORT = 3000
app.listen PORT, ->
  console.log "Listening on " + PORT


#var port = process.env.PORT || 3000;
#app.listen(port, function() {
#  console.log("Listening on " + port);
#});
#