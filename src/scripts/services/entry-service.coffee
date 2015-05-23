moment = require 'moment'
request = require 'request'
getEntry = require '../models/entry'

class EntryService
  close: ->
    getEntry().select null

  fetchAll: ->
    baseUrl = location.protocol + '//' + location.host
    request
      url: baseUrl + '/posts.json'
      json: true
      withCredentials: false
    , (err, res) ->
      entries = res.body
      getEntry().saveAll entries.reverse()

  fetchOne: (entry) ->
    baseUrl = location.protocol + '//' + location.host
    date = entry.date
    d = moment date
    request
      url: baseUrl + '/' + d.format('YYYY/MM/DD') + '/index.json'
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

  nextPage: ->
    { start, end } = getEntry().getLimit()
    getEntry().saveLimit start, end + 30

  search: (s) ->
    getEntry().saveSearchText s

  setSearchVisible: (isVisible) ->
    getEntry().saveSearchVisible isVisible

module.exports = ->
  new EntryService()

module.exports.EntryService = EntryService
