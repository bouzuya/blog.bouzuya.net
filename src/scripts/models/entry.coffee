{EventEmitter} = require 'events'

class Entry
  @events: new EventEmitter()

module.exports.Entry = Entry
