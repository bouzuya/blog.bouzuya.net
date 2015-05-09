getEntry = require '../models/entry'

class EntryViewer
  constructor: (store) ->
    @_store = store

  getAll: ->
    @_store.getAll()

  getEventEmitter: ->
    @_store.getEventEmitter()

  getSelectedEntry: ->
    @_store.getSelectedEntry()

module.exports = ->
  instance = getEntry()
  new EntryViewer(instance)

module.exports.EntryViewer = EntryViewer
