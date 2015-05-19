React = require 'react'
{EntryView} = require '../views/entry-view'

class EntryDetailView extends React.Component
  @propTypes:
    entry: React.PropTypes.object

  constructor: (props) ->
    super props

  render: ->
    if @props.entry?
      React.createElement 'div', {
        className: 'entry-detail-container is-open'
      },
        React.createElement 'div', { className: 'entry-detail' },
          React.createElement EntryView,
            entry: @props.entry
            isOpen: true
    else
      React.createElement 'div', { className: 'entry-detail-container' }

module.exports.EntryDetailView = EntryDetailView
