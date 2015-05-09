React = require 'react'
getEntryService = require '../services/entry-service'
getEntryViewer = require '../viewers/entry-viewer'
{HeaderView} = require './header-view'
{ContentView} = require './content-view'
{FooterView} = require './footer-view'

class AppView extends React.Component
  @propTypes: {}

  constructor: (props) ->
    super props
    @onEntriesChanged = @onEntriesChanged.bind @
    @onEntrySelected = @onEntrySelected.bind @
    @state =
      entries: getEntryViewer().getAll()
      entry: null

  componentDidMount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.addListener 'changed', @onEntriesChanged
    emitter.addListener 'selected', @onEntrySelected
    getEntryService().fetch()

  componentWillUnmount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.removeListener 'changed', @onEntriesChanged
    emitter.removeListener 'selected', @onEntrySelected

  onEntriesChanged: (entries) ->
    @setState { entries, entry: null }

  onEntrySelected: (entry) ->
    @setState { entries: @state.entries, entry }

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
