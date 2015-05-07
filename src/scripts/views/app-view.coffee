React = require 'react'
{HeaderView} = require './header-view'
{ContentView} = require './content-view'
{FooterView} = require './footer-view'

class AppView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'app',
      React.createElement(HeaderView),
      React.createElement(ContentView),
      React.createElement(FooterView)

module.exports.AppView = AppView
