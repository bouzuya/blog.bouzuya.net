{EventEmitter} = require 'events'

class Entry
  @_instance: null

  @getInstance: ->
    @_instance = new Entry() unless @_instance?
    @_instance

  constructor: ->
    @_entries = []
    @_entry = null
    @_emitter = new EventEmitter()

  getAll: ->
    @_entries

  getEventEmitter: ->
    @_emitter

  save: (entries) ->
    @_entries = entries
    @_emitter.emit 'changed', @_entries

  select: (entry) ->
    @_entry = entry
    @_emitter.emit 'selected', @_entry

module.exports = ->
  Entry.getInstance()

module.exports.Entry = Entry
