getEntryEvent = require '../events/entry-event'

class Entry
  @_instance: null

  @getInstance: ->
    @_instance = new Entry() unless @_instance?
    @_instance

  constructor: ->
    @_entries = []

  getAll: ->
    @_entries

  save: (entries) ->
    @_entries = entries
    getEntryEvent().emit 'changed', @_entries

module.exports = ->
  Entry.getInstance()

module.exports.Entry = Entry
