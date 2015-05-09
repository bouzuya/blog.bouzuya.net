{EventEmitter} = require 'events'

class EntryEvent extends EventEmitter
  @_instance: null

  @getInstance: ->
    @_instance = new EntryEvent() unless @_instance?
    @_instance

module.exports = ->
  EntryEvent.getInstance()

module.exports.EntryEvent = EntryEvent
