React = require 'react'

class HeaderView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'header',
      React.createElement('a', { className: 'title', href: '/' },
        'blog.bouzuya.net'),
      React.createElement 'button', { className: 'search-button' },
        React.createElement 'i', { className: 'fa fa-search' }

module.exports.HeaderView = HeaderView
