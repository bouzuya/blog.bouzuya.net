React = require 'react'
{Entry} = require '../models/entry'
{EntryService} = require '../services/entry-service'
{HeaderView} = require './header-view'
{ContentView} = require './content-view'
{FooterView} = require './footer-view'

class AppView extends React.Component
  @propTypes: {}

  constructor: (props) ->
    super props
    @onEntriesChanged = @onEntriesChanged.bind @
    @state =
      entries: []
      entry: null

  componentDidMount: ->
    Entry.events.addListener 'changed', @onEntriesChanged
    EntryService.fetch()

  componentWillUnmount: ->
    Entry.events.removeListener 'changed', @onEntriesChanged

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
