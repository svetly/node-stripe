noflo = require 'noflo'

class ConvertStripeAmount extends noflo.Component
  constructor: ->
    @inPorts =
      in: new noflo.Port
    @outPorts =
      out: new noflo.Port
      
    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send data / 100
    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect()
      
exports.getComponent = -> new ConvertStripeAmount