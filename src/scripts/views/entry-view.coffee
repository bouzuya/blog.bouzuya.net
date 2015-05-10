React = require 'react'
getEntryService = require '../services/entry-service'

class EntryView extends React.Component
  @propTypes:
    entry: React.PropTypes.object
    isOpen: React.PropTypes.bool

  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', {
      className: 'entry' + (if @props.isOpen then ' is-open' else '')
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
    null

module.exports.EntryView = EntryView
