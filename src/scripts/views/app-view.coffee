React = require 'react'
{EntryService} = require '../services/entry-service'
{EventService} = require '../services/event-service'
{HeaderView} = require './header-view'
{ContentView} = require './content-view'
{FooterView} = require './footer-view'

class AppView extends React.Component
  @propTypes: {}

  constructor: (props) ->
    super props
    @events = EventService.getInstance()
    @onEntriesChanged = @onEntriesChanged.bind @
    @state =
      entries: []
      entry: null

  componentDidMount: ->
    @events.addListener 'entries-changed', @onEntriesChanged
    EntryService.fetch()

  componentWillUnmount: ->
    @events.removeListener 'entries-changed', @onEntriesChanged

  onEntriesChanged: (entries) ->
    @setState { entries: entries, entry: null }

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
