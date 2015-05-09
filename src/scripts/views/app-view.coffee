React = require 'react'
{HeaderView} = require './header-view'
{ContentView} = require './content-view'
{FooterView} = require './footer-view'

class AppView extends React.Component
  @propTypes: {}

  constructor: (props) ->
    super props
    @state =
      entries: [1..30].map (i) ->
        date: '2015-04-' + (if i < 10 then '0' + i else i) + ''
        title: 'entry ' + i
        content: [1...i].map((j) ->
          '<p>あいうえおかきくけこさしすせそたちつてとなにぬねの</p>'
        ).join '\n'
      entry: null

  onOpen: (entry) ->
    @setState { entries: @state.entries, entry }

  onClose: ->
    @setState { entries: @state.entries, entry: null }

  render: ->
    React.createElement 'div', id: 'app',
      React.createElement(HeaderView),
      React.createElement(ContentView,
        entries: @state.entries
        entry: @state.entry
        onOpen: @onOpen.bind(@)
        onClose: @onClose.bind(@)
      ),
      React.createElement(FooterView)

module.exports.AppView = AppView
