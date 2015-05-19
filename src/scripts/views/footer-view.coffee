React = require 'react'

class FooterView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'footer'

module.exports.FooterView = FooterView
