getEntry = require '../models/entry'

class EntryService
  close: ->
    getEntry().select null

  fetch: ->
    entries = [1..30].map (i) ->
      date: '2015-04-' + (if i < 10 then '0' + i else i) + ''
      title: 'entry ' + i
      content: [1...i].map((j) ->
        '<p>あいうえおかきくけこさしすせそたちつてとなにぬねの</p>'
      ).join '\n'
    getEntry().save entries

module.exports = ->
  new EntryService()

module.exports.EntryService = EntryService
