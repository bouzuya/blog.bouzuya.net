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

  getSelectedEntry: ->
    @_entry

  save: (entries) ->
    @_entries = entries
    @_emitter.emit 'changed', @_entries

  saveEntry: (entry) ->
    filtered = @_entries.filter((i) -> i.date is entry.date)[0]
    return unless filtered?
    filtered.title = entry.title
    filtered.content = entry.content
    @_emitter.emit 'loaded', filtered

  select: (entry) ->
    @_entry = entry
    @_emitter.emit 'selected', @_entry

module.exports = ->
  Entry.getInstance()

module.exports.Entry = Entry
