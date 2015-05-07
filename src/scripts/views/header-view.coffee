React = require 'react'

class HeaderView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'header'

module.exports.HeaderView = HeaderView
