React = require 'react'
{EntryListView} = require './entry-list-view'
{EntryDetailView} = require './entry-detail-view'

class ContentView extends React.Component
  @propTypes:
    entries: React.PropTypes.array
    entry: React.PropTypes.object
    onClose: React.PropTypes.func
    onOpen: React.PropTypes.func

  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'content-container',
      React.createElement 'div', id: 'content',
        React.createElement(EntryListView,
          entries: @props.entries
          entry: @props.entry
          onOpen: @props.onOpen
          onClose: @props.onClose
        ),
        React.createElement EntryDetailView, entry: @props.entry

module.exports.ContentView = ContentView
