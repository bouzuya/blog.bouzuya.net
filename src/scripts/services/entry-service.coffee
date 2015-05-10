request = require 'request'
getEntry = require '../models/entry'

class EntryService
  close: ->
    getEntry().select null

  fetchAll: ->
    request
      url: 'http://blog.bouzuya.net/posts.json'
      json: true
      withCredentials: false
    , (err, res) ->
      entries = res.body
      getEntry().saveAll entries

  fetchOne: (entry) ->
    date = entry.date
    request
      url: 'http://blog.bouzuya.net/posts/' + entry.date + '.json'
      json: true
      withCredentials: false
    , (err, res) ->
      fetched = res.body
      getEntry().saveOne
        date: fetched.date
        title: fetched.title
        content: fetched.html

  open: (entry) ->
    getEntry().select entry

module.exports = ->
  new EntryService()

module.exports.EntryService = EntryService
