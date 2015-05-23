React = require 'react'

class FooterView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', className: 'footer-layout'

module.exports.FooterView = FooterView
