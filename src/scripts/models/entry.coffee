{EventEmitter} = require 'events'

class Entry
  @_instance: null

  @getInstance: ->
    @_instance = new Entry() unless @_instance?
    @_instance

  constructor: ->
    @_entries = []
    @_entry = null
    @_start = 0
    @_end = 30
    @_emitter = new EventEmitter()

  getAll: ->
    @_entries.filter (_, index) =>
      @_start <= index and index <= @_end

  getEventEmitter: ->
    @_emitter

  getLimit: ->
    start: @_start
    end: @_end

  getSelectedEntry: ->
    @_entry

  saveAll: (entries) ->
    @_entries = entries
    filtered = @_entries.filter (_, index) =>
      @_start <= index and index <= @_end
    @_emitter.emit 'entries-changed',
      entries: filtered
      hasNext: @_entries.length > @_end - @_start

  saveLimit: (start, end) ->
    @_start = start
    @_end = end
    filtered = @_entries.filter (_, index) =>
      @_start <= index and index <= @_end
    @_emitter.emit 'entries-changed',
      entries: filtered
      hasNext: @_entries.length > @_end - @_start

  saveOne: (entry) ->
    filtered = @_entries.filter((i) -> i.date is entry.date)[0]
    return unless filtered?
    filtered.title = entry.title
    filtered.content = entry.content
    @_emitter.emit 'entry-changed', filtered

  select: (entry) ->
    @_entry = entry
    @_emitter.emit 'selected', @_entry

module.exports = ->
  Entry.getInstance()

module.exports.Entry = Entry
