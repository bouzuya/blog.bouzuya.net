React = require 'react'

class AppView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', className: 'app'

module.exports.AppView = AppView
