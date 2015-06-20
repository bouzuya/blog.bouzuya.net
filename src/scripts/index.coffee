React = require 'react'
{AppView} = require './views/app-view'
getEntryService = require './services/entry-service'
getRouteService = require './services/route-service'

window.addEventListener 'DOMContentLoaded', ->
  router = getRouteService()
  router.config [
    path: '^/(\\d{4})/(\\d{2})/(\\d{2})/$'
    action: ([_, year, month, date]) ->
      getEntryService().fetchOne date: "#{year}-#{month}-#{date}"
  ,
    path: '^/(?:\\?q=(.*))?$'
    action: ([_, query]) ->
      entryService = getEntryService()
      entryService.fetchAll()
      entryService.search(query) if query?.length > 0
  ]
  props = window.INITIAL_PROPS ? {}
  rootElement = React.createFactory(AppView)(props)
  React.render rootElement, document.body
  router.start()
  setTimeout ->
    console.log '%c   ([:-P   ', 'font-size: 128px; font-family: "Fredoka One"'
  , 1000
