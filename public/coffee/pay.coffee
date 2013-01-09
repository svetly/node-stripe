
publicStripeApiKey = '...';
publicStripeApiKeyTesting = 'pk_test_AA5XOx7UCeW0BIcpxBSE8vzh';

Stripe.setPublishableKey(publicStripeApiKeyTesting);

stripeResponseHandler = (status, response) ->
  
  if response.error
    #show the errors on the form
    $(".payment-errors").text(response.error.message);
    # show the errors on the form
    $(".submit-button").removeAttr ("disabled")
  else
    form$ = $("#payment-form")
    # token contains id, last4, and card type
    token = response['id'];
    # insert the token into the form so it gets submitted to the server
    form$.append("<input type='hidden' name='stripeToken' id='stripeToken' value='#{token}' />")
    # and submit
    form$.get(0).submit()

$(document).ready ->
  $("#payment-form").submit (event) ->
    # disable the submit button to prevent repeated clicks
    $('.submit-button').attr("disabled", "disabled")
    # createToken returns immediately - the supplied callback submits the form if there are no errors
    Stripe.createToken {
      number: $('.card-number').val()
      cvc: $('.card-cvc').val()
      exp_month: $('.card-expiry-month').val()
      exp_year: $('.card-expiry-year').val()
    }, stripeResponseHandler
    return false