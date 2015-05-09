getEntry = require '../models/entry'

class EntryViewer
  constructor: (store) ->
    @_store = store

  getAll: ->
    @_store.getAll()

module.exports = ->
  instance = getEntry()
  new EntryViewer(instance)

module.exports.EntryViewer = EntryViewer
