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
    @_onEntriesChanged = @_onEntriesChanged.bind @
    @_onEntrySelected = @_onEntrySelected.bind @
    @state =
      entries: getEntryViewer().getAll()
      entry: getEntryViewer().getSelectedEntry()

  componentDidMount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.addListener 'changed', @_onEntriesChanged
    emitter.addListener 'selected', @_onEntrySelected
    getEntryService().fetch()

  componentWillUnmount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.removeListener 'changed', @_onEntriesChanged
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

  _onEntrySelected: (entry) ->
    @setState { entries: @state.entries, entry }


module.exports.AppView = AppView
