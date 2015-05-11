React = require 'react'
getEntryService = require '../services/entry-service'
getRouteService = require '../services/route-service'

class EntryView extends React.Component
  @propTypes:
    entry: React.PropTypes.object
    isOpen: React.PropTypes.bool

  constructor: (props) ->
    super props

  componentDidMount: ->
    return unless @props.isOpen
    return if @props.entry.content?
    setTimeout =>
      getEntryService().fetchOne(@props.entry)
    , 300

  render: ->
    React.createElement 'div', {
      className: 'entry' + (if @props.isOpen then ' is-open' else '')
    },
      React.createElement('div', { className: 'entry-date' },
        @props.entry.date),
      React.createElement('div', {
        className: 'entry-title'
        onClick: @_onClick.bind(@)
      }, @props.entry.title),
      React.createElement('div',
        className: 'entry-content'
        dangerouslySetInnerHTML:
          __html: @props.entry.content || ''
      )

  _onClick: (e) ->
    return unless @props.isOpen
    getRouteService().back()
    null

module.exports.EntryView = EntryView
