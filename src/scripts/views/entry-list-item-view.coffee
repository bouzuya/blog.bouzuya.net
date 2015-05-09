React = require 'react'
{EntryView} = require './entry-view'

class EntryListItemView extends React.Component
  @propTypes:
    entry: React.PropTypes.object
    isOpen: React.PropTypes.bool
    onOpen: React.PropTypes.func

  onClick: ->
    return if @props.isOpen
    @props.onOpen @props.entry

  render: ->
    React.createElement 'li', {
      className: 'entry-list-item' + (if @props.isOpen then ' is-open' else '')
      onClick: @onClick.bind(@)
    },
    React.createElement EntryView,
      entry: @props.entry
      isOpen: false

module.exports.EntryListItemView = EntryListItemView
