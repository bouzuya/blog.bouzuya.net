{EventService} = require './event-service'

class EntryService
  @fetch: ->
    setTimeout ->
      entries = [1..30].map (i) ->
        date: '2015-04-' + (if i < 10 then '0' + i else i) + ''
        title: 'entry ' + i
        content: [1...i].map((j) ->
          '<p>あいうえおかきくけこさしすせそたちつてとなにぬねの</p>'
        ).join '\n'
      events = EventService.getInstance()
      events.emit 'changed', entries
    , 0

module.exports.EntryService = EntryService
