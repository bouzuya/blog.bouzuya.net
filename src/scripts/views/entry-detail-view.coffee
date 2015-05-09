React = require 'react'
{EntryView} = require '../views/entry-view'

class EntryDetailView extends React.Component
  @propTypes:
    entry: React.PropTypes.object

  constructor: (props) ->
    super props

  render: ->
    return null unless @props.entry?
    React.createElement 'div', { className: 'entry-detail' },
      React.createElement EntryView,
        entry: @props.entry
        isOpen: true

module.exports.EntryDetailView = EntryDetailView
