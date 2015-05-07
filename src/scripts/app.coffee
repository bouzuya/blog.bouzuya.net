React = require 'react'
{AppView} = require './views/app-view'

class App
  constructor: ->
    data =
      entries: [
        date: '2015-04-01'
        title: 'entry 1'
      ,
        date: '2015-04-02'
        title: 'entry 2'
        content: '''
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        <p>fooooooooooooooooooooooooooooooooooooooooooooooooooooo</p>
        '''
      ,
        date: '2015-04-03'
        title: 'entry 3'
      ,
        date: '2015-04-04'
        title: 'entry 4'
    ]

    rootElement = React.createElement AppView, data
    React.render rootElement, document.body

module.exports.App = App
