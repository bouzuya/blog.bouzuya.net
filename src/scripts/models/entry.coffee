{EntryEvent} = require '../events/entry-event'

class Entry
  constructor: ->
    @_entries = []

  getAll: ->
    @_entries

  save: (entries) ->
    @_entries = entries
    EntryEvent.emit 'changed', @_entries

module.exports.Entry = new Entry
