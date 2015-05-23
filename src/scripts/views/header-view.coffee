React = require 'react'
getEntryService = require '../services/entry-service'

class HeaderView extends React.Component
  @propTypes:
    searchText: React.PropTypes.string
    visible: React.PropTypes.bool

  constructor: (props) ->
    super props
    @state =
      value: props.searchText
    @_onChange = @_onChange.bind @
    @_onClick = @_onClick.bind @
    @_onKeyDown = @_onKeyDown.bind @

  render: ->
    isVisible = (if @props.visible then ' is-visible' else '')
    React.createElement 'div', className: 'header-layout',
      React.createElement('a', { className: 'title', href: '/' },
        'blog.bouzuya.net'),
      React.createElement 'div', { className: 'search-header' },
        React.createElement('input',
          ref: 'input'
          className: 'search-text' + isVisible
          type: 'text'
          value: @state.value
          onChange: @_onChange
          onKeyDown: @_onKeyDown
        ),
        React.createElement 'button', {
          className: 'search-button'
          onClick: @_onClick
        },
          React.createElement 'i', { className: 'fa fa-search' }

  _onChange: (e) ->
    @setState value: e.target.value
    null

  _onClick: ->
    getEntryService().setSearchVisible not @props.visible
    null

  _onKeyDown: (e) ->
    getEntryService().search(@state.value) if e.keyCode is 0x0D
    null

module.exports.HeaderView = HeaderView
