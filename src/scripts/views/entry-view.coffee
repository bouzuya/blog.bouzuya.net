React = require 'react'
getEntryService = require '../services/entry-service'

class EntryView extends React.Component
  @propTypes:
    entries: React.PropTypes.array
    entry: React.PropTypes.object
    onOpen: React.PropTypes.func

  constructor: (props) ->
    super props

  onClick: ->
    getEntryService().close()

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
