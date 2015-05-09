React = require 'react'
getEntryService = require '../services/entry-service'
{EntryView} = require '../views/entry-view'

class EntryListItemView extends React.Component
  @propTypes:
    entry: React.PropTypes.object
    isOpen: React.PropTypes.bool

  render: ->
    React.createElement 'li', {
      className: 'entry-list-item' + (if @props.isOpen then ' is-open' else '')
      onClick: @_onClick.bind(@)
    },
    React.createElement EntryView,
      entry: @props.entry
      isOpen: false

  _onClick: ->
    return if @props.isOpen
    getEntryService().open @props.entry
    null

module.exports.EntryListItemView = EntryListItemView
