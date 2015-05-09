React = require 'react'
{EntryListItemView} = require './entry-list-item-view'

class EntryListView extends React.Component
  @propTypes:
    entries: React.PropTypes.array
    entry: React.PropTypes.object
    onClose: React.PropTypes.func
    onOpen: React.PropTypes.func

  constructor: (props) ->
    super props

  render: ->
    React.createElement 'ul', { className: 'entry-list' },
      @props.entries.map (i, index) =>
        React.createElement EntryListItemView,
          entry: i
          index: index
          isOpen: i is @props.entry
          onOpen: @props.onOpen
          onClose: @props.onClose

module.exports.EntryListView = EntryListView
