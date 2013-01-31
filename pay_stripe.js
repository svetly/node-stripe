// Generated by CoffeeScript 1.4.0
(function() {
  var flows;

  flows = require('./flows');

  exports.process_payment_basic = function(req, res) {
    var api_key, chargeData, customerData;
    console.log("Basic Account Initiated");
    api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';
    chargeData = {
      amount: 2000,
      currency: "usd",
      description: "One time payment. Email: " + req.body.userEmail
    };
    customerData = {
      card: req.body.stripeToken,
      email: req.body.userEmail
    };
    return flows.processPayment(api_key, chargeData, customerData, function(err, charge) {
      var id;
      if (err) {
        console.log(err);
        res.send("Error while processing your payment " + err.response.error.message);
        return;
      }
      id = charge.customer;
      console.log("Success! Customer with Stripe ID " + id + " just signed up!");
      return res.render('order_result.ejs', {
        title: 'Your single payment order has been placed. Thank you for supporting the Grid!!'
      });
    });
  };

  exports.process_payment_pro = function(req, res) {
    var api_key, stripe, token, _ref;
    res.render('plan_result.ejs', {
      title: 'You have been subscribed to the Pro Plan. Thank you for supporting The Grid!!'
    });
    console.log("Pro Account Initiated");
    api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';
    stripe = require('stripe')(api_key);
    token = req != null ? (_ref = req.body) != null ? _ref.stripeToken : void 0 : void 0;
    if (!token) {
      console.log("token not found");
    }
    return stripe.customers.create({
      card: req.body.stripeToken,
      email: req.body.userEmail,
      plan: "plans_pro"
    }, function(err, customer) {
      var id, msg;
      if (err) {
        msg = customer.error.message || "unknown";
        return res.send("Error while processing your payment " + msg);
      } else {
        id = customer.id;
        console.log("Success! Customer with Stripe ID " + id + " just signed up!");
        return res.send('ok');
      }
    });
  };

  exports.process_payment_developer = function(req, res) {
    var api_key, stripe, token, _ref;
    res.render('plan_result.ejs', {
      title: 'You have been subscribed to the Pro Plan. Thank you For Supporting the Grid!!'
    });
    api_key = 'sk_test_ixWCFyk1Jl9Rt6TtLMkzg3Qd';
    stripe = require('stripe')(api_key);
    token = req != null ? (_ref = req.body) != null ? _ref.stripeToken : void 0 : void 0;
    if (!token) {
      console.log("token not found");
    }
    return stripe.customers.create({
      card: req.body.stripeToken,
      email: req.body.userEmail,
      plan: "plans_developer"
    }, function(err, customer) {
      var id, msg;
      if (err) {
        msg = customer.error.message || "unknown";
        return res.send("Error while processing your payment " + msg);
      } else {
        id = customer.id;
        console.log("Success! Customer with Stripe ID " + id + " just signed up!");
        return res.send('ok');
      }
    });
  };

}).call(this);
