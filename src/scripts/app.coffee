React = require 'react'
{AppView} = require './views/app-view'

class App
  constructor: ->
    data =
      entries: [1..30].map (i) ->
        date: '2015-04-' + (if i < 10 then '0' + i else i) + ''
        title: 'entry ' + i
        content: [1...i].map((j) ->
          '<p>あいうえおかきくけこさしすせそたちつてとなにぬねの</p>'
        ).join '\n'

    rootElement = React.createElement AppView, data
    React.render rootElement, document.body

module.exports.App = App
