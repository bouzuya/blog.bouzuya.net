getEntry = require '../models/entry'

class EntryService
  close: ->
    getEntry().select null

  fetch: ->
    entries = [1..30].map (i) ->
      date: '2015-04-' + (if i < 10 then '0' + i else i) + ''
      title: 'entry ' + i
      content: [1...i].map((j) ->
        '''
        <p>あいうえお</p>
        <p>かきくけこ</p>
        <p>さしすせそ</p>
        <p>たちつてと</p>
        <p>なにぬねの</p>
        <p>はひふへほ</p>
        <p>まみむめも</p>
        <p>やゆよ</p>
        '''
      ).join '\n'
    getEntry().save entries

  open: (entry) ->
    getEntry().select entry

module.exports = ->
  new EntryService()

module.exports.EntryService = EntryService
