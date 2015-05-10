request = require 'request'
getEntry = require '../models/entry'

class EntryService
  close: ->
    getEntry().select null

  fetch: ->
    request
      url: 'http://blog.bouzuya.net/posts.json'
      json: true
      withCredentials: false
    , (err, res) ->
      entries = res.body
      getEntry().save entries

  fetchEntry: (entry) ->
    date = entry.date
    request
      url: 'http://blog.bouzuya.net/posts/' + entry.date + '.json'
      json: true
      withCredentials: false
    , (err, res) ->
      loaded = res.body
      loaded.content = loaded.html
      getEntry().saveEntry loaded

  open: (entry) ->
    getEntry().select entry

module.exports = ->
  new EntryService()

module.exports.EntryService = EntryService
