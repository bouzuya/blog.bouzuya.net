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
    @_onEntryChanged = @_onEntryChanged.bind @
    @state =
      entries: getEntryViewer().getAll()
      entry: getEntryViewer().getSelectedEntry()

  componentDidMount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.addListener 'entries-changed', @_onEntriesChanged
    emitter.addListener 'entry-changed', @_onEntryChanged
    emitter.addListener 'selected', @_onEntryChanged
    getEntryService().fetchAll()

  componentWillUnmount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.removeListener 'entries-changed', @_onEntriesChanged
    emitter.removeListener 'entry-changed', @_onEntryChanged
    emitter.removeListener 'selected', @_onEntryChanged

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

  _onEntryChanged: (entry) ->
    @setState { entries: @state.entries, entry }

module.exports.AppView = AppView
