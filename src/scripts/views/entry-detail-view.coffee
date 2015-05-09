React = require 'react'
{EntryView} = require '../views/entry-view'

class EntryDetailView extends React.Component
  @propTypes:
    entry: React.PropTypes.object

  constructor: (props) ->
    super props

  render: ->
    if @props.entry?
      React.createElement 'div', { className: 'entry-detail is-open' },
        React.createElement EntryView,
          entry: @props.entry
          isOpen: true
    else
      React.createElement 'div', { className: 'entry-detail' }

module.exports.EntryDetailView = EntryDetailView
