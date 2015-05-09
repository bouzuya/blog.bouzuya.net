{EventEmitter} = require 'events'

class EventService extends EventEmitter
  @getInstance: ->
    @instance = new EventService() unless @instance?
    @instance

module.exports.EventService = EventService
