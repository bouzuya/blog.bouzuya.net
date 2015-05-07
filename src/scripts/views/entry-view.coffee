React = require 'react'

class EntryView extends React.Component
  constructor: (props) ->
    super props

  onClick: ->
    @props.onHeaderClick()

  render: ->
    React.createElement 'div', {
      className: 'entry' + (isOpen ? ' is-open' : '')
    },
    React.createElement('div', { className: 'entry-date' }, @props.entry.date),
    React.createElement('div', {
      className: 'entry-title'
      onClick: @onClick.bind(@)
    }, @props.entry.title),
    React.createElement('div',
      className: 'entry-content'
      dangerouslySetInnerHTML:
        __html: @props.entry.content || ''
    )

module.exports.EntryView = EntryView
