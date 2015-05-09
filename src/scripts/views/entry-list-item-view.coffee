React = require 'react'
getEntryService = require '../services/entry-service'
{EntryView} = require '../views/entry-view'

class EntryListItemView extends React.Component
  @propTypes:
    entry: React.PropTypes.object
    isOpen: React.PropTypes.bool

  onClick: ->
    return if @props.isOpen
    getEntryService().open @props.entry

  render: ->
    React.createElement 'li', {
      className: 'entry-list-item' + (if @props.isOpen then ' is-open' else '')
      onClick: @onClick.bind(@)
    },
    React.createElement EntryView,
      entry: @props.entry
      isOpen: false

module.exports.EntryListItemView = EntryListItemView
