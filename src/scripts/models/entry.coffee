{EventEmitter} = require 'events'

class Entry
  @_instance: null

  @getInstance: ->
    @_instance = new Entry() unless @_instance?
    @_instance

  constructor: ->
    @_entries = []
    @_emitter = new EventEmitter()

  getAll: ->
    @_entries

  getEventEmitter: ->
    @_emitter

  save: (entries) ->
    @_entries = entries
    @_emitter.emit 'changed', @_entries

module.exports = ->
  Entry.getInstance()

module.exports.Entry = Entry
