
exports.process_payment_basic = (req,res) ->
  res.render 'plan_result.ejs'
    title: 'Thanks For Supporting the Grid!!'
  
  
  console.log "Basic Account Initiated"

  api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';  # secret stripe API key
  stripe = require('stripe')(api_key);

# get the credit card details submitted by the form
  token = req?.body?.stripeToken
  if !token then console.log("token not found")
  else console.log(req.body)
  
  stripe.charges.create
    amount: 2000
    currency: "usd"
    card: token
    description: "svetly@example.com"

exports.process_payment_pro = (req,res) ->
  console.log "Pro Account Initiated"

  api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';  # secret stripe API key
  stripe = require('stripe')(api_key);

  # get the credit card details submitted by the form
  token = req?.body?.stripeToken
  if !token then console.log("token not found")

  # create a Customer
  stripe.customers.create
    card: req.body.stripeToken
    email: "daniel@gmail.com" #customer email, get it from db or session
    plan: "plans_pro"
    (err, customer) ->
     if (err)
       msg = customer.error.message || "unknown"
       res.send "Error while processing your payment #{msg}"
     else
       id = customer.id
       console.log "Success! Customer with Stripe ID #{id} just signed up!"
       #save customer to database here!
       res.send('ok')


exports.process_payment_developer = (req,res) ->
#  res.render 'plan_result.ejs', { 
#    title: 'Thanks For Supporting Us!!'
#  }

  api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';  # secret stripe API key
  stripe = require('stripe')(api_key);

  # get the credit card details submitted by the form
  token = req?.body?.stripeToken
  if !token then console.log("token not found")

  # create a Customer
  stripe.customers.create
    card: req.body.stripeToken
    email: "developer@example.com" #customer email, get it from db or session
    plan: "plans_developer"
    (err, customer) ->
     if (err)
       msg = customer.error.message || "unknown"
       res.send "Error while processing your payment #{msg}"
     else
       id = customer.id
       console.log "Success! Customer with Stripe ID #{id} just signed up!"
       #save customer to database here!
       res.send('ok')


