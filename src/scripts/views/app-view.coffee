React = require 'react'

class AppView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'app'

module.exports.AppView = AppView
