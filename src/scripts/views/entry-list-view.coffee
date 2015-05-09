React = require 'react'
{EntryListItemView} = require '../views/entry-list-item-view'

class EntryListView extends React.Component
  @propTypes:
    entries: React.PropTypes.array
    entry: React.PropTypes.object

  constructor: (props) ->
    super props

  render: ->
    React.createElement 'ul', { className: 'entry-list' },
      @props.entries.map (i, index) =>
        React.createElement EntryListItemView,
          entry: i
          index: index
          key: i.date
          isOpen: i is @props.entry

module.exports.EntryListView = EntryListView
