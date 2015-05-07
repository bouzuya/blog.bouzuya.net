React = require 'react'

class ContentView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'content'

module.exports.ContentView = ContentView
