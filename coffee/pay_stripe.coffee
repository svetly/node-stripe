flows = require './flows'

exports.process_payment_basic = (req,res) ->    
  console.log "Basic Account Initiated"

  api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';  # secret stripe API key
  
  chargeData =
    amount: 2000
    currency: "usd"
    description: "One time payment. Email: #{req.body.userEmail}"
    
  customerData =
    card: req.body.stripeToken
    email: req.body.userEmail #customer email, get it from db or session
    
  flows.processPayment api_key, chargeData, customerData, (err, charge) ->
    if err
      console.log err
      res.send "Error while processing your payment #{err.response.error.message}"
      return
    id = charge.customer
    console.log "Success! Customer with Stripe ID #{id} just signed up!"
    res.render 'order_result.ejs'
      title: 'Your single payment order has been placed. Thank you for supporting the Grid!!'

exports.process_payment_pro = (req,res) ->
  res.render 'plan_result.ejs'
    title: 'You have been subscribed to the Pro Plan. Thank you for supporting The Grid!!'

  console.log "Pro Account Initiated"

  api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';  # secret stripe API key
  stripe = require('stripe')(api_key);

  # get the credit card details submitted by the form
  token = req?.body?.stripeToken
  if !token then console.log("token not found")

  # create a Customer
  stripe.customers.create
    card: req.body.stripeToken
    email: req.body.userEmail #customer email, get it from db or session
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
  res.render 'plan_result.ejs'
    title: 'You have been subscribed to the Pro Plan. Thank you For Supporting the Grid!!'

  api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';  # secret stripe API key
  stripe = require('stripe')(api_key);

  # get the credit card details submitted by the form
  token = req?.body?.stripeToken
  if !token then console.log("token not found")

  # create a Customer
  stripe.customers.create
    card: req.body.stripeToken
    email: req.body.userEmail #customer email, get it from db or session
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


