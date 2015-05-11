React = require 'react'
getRouteService = require '../services/route-service'
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
    getRouteService().go '/' + @props.entry.date
    null

module.exports.EntryListItemView = EntryListItemView
