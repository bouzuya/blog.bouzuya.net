React = require 'react'
{EntryDetailView} = require '../views/entry-detail-view'
{EntryListView} = require '../views/entry-list-view'

class ContentView extends React.Component
  @propTypes:
    entries: React.PropTypes.array
    entry: React.PropTypes.object

  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'content-container',
      React.createElement 'div', id: 'content',
        React.createElement(EntryListView,
          entries: @props.entries
          entry: @props.entry
        ),
        React.createElement EntryDetailView, entry: @props.entry

module.exports.ContentView = ContentView
