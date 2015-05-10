React = require 'react'
getEntryService = require '../services/entry-service'
getEntryViewer = require '../viewers/entry-viewer'
{ContentView} = require '../views/content-view'
{FooterView} = require '../views/footer-view'
{HeaderView} = require '../views/header-view'

class AppView extends React.Component
  @propTypes: {}

  constructor: (props) ->
    super props
    @_onEntriesChanged = @_onEntriesChanged.bind @
    @_onEntryLoaded = @_onEntryLoaded.bind @
    @_onEntrySelected = @_onEntrySelected.bind @
    @state =
      entries: getEntryViewer().getAll()
      entry: getEntryViewer().getSelectedEntry()

  componentDidMount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.addListener 'changed', @_onEntriesChanged
    emitter.addListener 'loaded', @_onEntryLoaded
    emitter.addListener 'selected', @_onEntrySelected
    getEntryService().fetch()

  componentWillUnmount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.removeListener 'changed', @_onEntriesChanged
    emitter.removeListener 'loaded', @_onEntryLoaded
    emitter.removeListener 'selected', @_onEntrySelected

  render: ->
    React.createElement 'div', id: 'app',
      React.createElement(HeaderView),
      React.createElement(ContentView,
        entries: @state.entries
        entry: @state.entry
      ),
      React.createElement(FooterView)

  _onEntriesChanged: (entries) ->
    @setState { entries, entry: null }

  _onEntryLoaded: (entry) ->
    @setState { entries: @state.entries, entry }

  _onEntrySelected: (entry) ->
    @setState { entries: @state.entries, entry }

module.exports.AppView = AppView
