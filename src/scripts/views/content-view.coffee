React = require 'react'
{EntryListView} = require './entry-list-view'

class ContentView extends React.Component
  constructor: (props) ->
    super props

  render: ->
    React.createElement 'div', id: 'content-container',
      React.createElement 'div', id: 'content',
        React.createElement EntryListView, entries: @props.entries

module.exports.ContentView = ContentView
