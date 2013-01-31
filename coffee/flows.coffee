noflo = require 'noflo'

exports.getPaymentGraph = (apiKey, chargeCb, errorCb) ->
  graph = new noflo.Graph 'ProcessPayment'
  graph.addNode 'Process', 'node-stripe/ProcessPayment'
  graph.addNode 'Charge', 'Callback'
  graph.addNode 'Error', 'Callback'
  # Connect them together
  graph.addEdge 'Process', 'charge', 'Charge', 'in'
  graph.addEdge 'Process', 'error', 'Error', 'in'
  # Provide API key
  graph.addInitial apiKey, 'Process', 'apikey'
  # Register callbacks
  graph.addInitial chargeCb, 'Charge', 'callback'
  graph.addInitial errorCb, 'Error', 'callback'
  graph
  
exports.processPayment = (apiKey, charge, customer, callback) ->
  # Prepare graph and callbacks
  graph = exports.getPaymentGraph apiKey
  , (charge) ->
    callback null, charge
  , (error) ->
    callback error, null
    
  # Prepare data
  graph.addInitial charge, 'Process', 'chargedata'
  graph.addInitial customer, 'Process', 'customerdata'
  
  # Run the flow
  noflo.createNetwork graph, (network) ->
    ###
    network.on 'data', (data) ->
      console.log data
    network.on 'start', (start) ->
      console.log start
    network.on 'end', (end) ->
      console.log end
    ###