React = require 'react'
{EntryListItemView} = require './entry-list-item-view'

class EntryListView extends React.Component
  constructor: (props) ->
    super props
    @state = openedEntryDate: null

  onOpen: (entry) ->
    @setState openedEntryDate: entry.date

  onClose: ->
    @setState openedEntryDate: null

  render: ->
    React.createElement 'ul', { className: 'entry-list' },
      @props.entries.map (i, index) =>
        React.createElement EntryListItemView,
          entry: i
          index: index
          isOpen: (i.date is @state.openedEntryDate)
          onOpen: @onOpen.bind(@)
          onClose: @onClose.bind(@)

module.exports.EntryListView = EntryListView
