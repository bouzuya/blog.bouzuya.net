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
      @props.entries.filter((_, index) -> index < 30).map (i) =>
        React.createElement EntryListItemView,
          entry: i
          key: i.date
          isOpen: i is @props.entry

module.exports.EntryListView = EntryListView
