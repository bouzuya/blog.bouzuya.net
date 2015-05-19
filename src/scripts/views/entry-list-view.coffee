React = require 'react'
{EntryListItemView} = require '../views/entry-list-item-view'
getEntryService = require '../services/entry-service'

class EntryListView extends React.Component
  @propTypes:
    entries: React.PropTypes.array
    entry: React.PropTypes.object
    hasNext: React.PropTypes.bool

  constructor: (props) ->
    super props
    @_onButtonClick = @_onButtonClick.bind @

  render: ->
    entries = @props.entries.map (i) =>
      React.createElement EntryListItemView,
        entry: i
        key: i.date
        isOpen: i is @props.entry
    if @props.hasNext
      button = React.createElement 'li', {
        key: 'button'
        className: 'entry-list-item-button'
      },
        React.createElement 'button', {
          className: 'entry-list-button'
          onClick: @_onButtonClick
        }, 'more'
      entries.push button
    React.createElement 'ul', { className: 'entry-list' }, entries

  _onButtonClick: ->
    getEntryService().nextPage()

module.exports.EntryListView = EntryListView
