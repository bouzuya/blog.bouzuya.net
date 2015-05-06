React = require 'react'
{AppView} = require './views/app-view'

class App
  constructor: ->
    rootElement = React.createElement AppView
    React.render rootElement, document.body

module.exports.App = App
