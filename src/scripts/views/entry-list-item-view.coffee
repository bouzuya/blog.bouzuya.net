React = require 'react'
{EntryView} = require './entry-view'

class EntryListItemView extends React.Component
  onClick: ->
    return if @props.isOpen
    @props.onOpen @props.entry

  onHeaderClick: ->
    return unless @props.isOpen
    @props.onClose @props.entry

  render: ->
    React.createElement 'li', {
      className: 'entry-list-item' + (if @props.isOpen then ' is-open' else '')
      onClick: @onClick.bind(@)
    },
    React.createElement EntryView,
      entry: @props.entry
      isOpen: false
      onHeaderClick: @onHeaderClick.bind(@)

module.exports.EntryListItemView = EntryListItemView
