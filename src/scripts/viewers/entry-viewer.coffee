{Entry} = require '../models/entry'

class EntryViewer
  getAll: ->
    Entry.getAll()

module.exports.EntryViewer = new EntryViewer()
