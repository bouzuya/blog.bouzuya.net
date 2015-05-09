{EventService} = require '../services/event-service'

class Entry
  @save: (entries) ->
    events = EventService.getInstance()
    events.emit 'entries-changed', entries

module.exports.Entry = Entry
