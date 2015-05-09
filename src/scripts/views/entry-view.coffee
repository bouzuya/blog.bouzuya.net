React = require 'react'
getEntryService = require '../services/entry-service'

class EntryView extends React.Component
  @propTypes:
    entry: React.PropTypes.object

  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', {
      className: 'entry' + (isOpen ? ' is-open' : '')
    },
    React.createElement('div', { className: 'entry-date' }, @props.entry.date),
    React.createElement('div', {
      className: 'entry-title'
      onClick: @_onClick.bind(@)
    }, @props.entry.title),
    React.createElement('div',
      className: 'entry-content'
      dangerouslySetInnerHTML:
        __html: @props.entry.content || ''
    )

  _onClick: ->
    getEntryService().close()


module.exports.EntryView = EntryView
