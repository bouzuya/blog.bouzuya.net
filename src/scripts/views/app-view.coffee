React = require 'react'
getEntryService = require '../services/entry-service'
getEntryViewer = require '../viewers/entry-viewer'
{ContentView} = require '../views/content-view'
{FooterView} = require '../views/footer-view'
{HeaderView} = require '../views/header-view'

class AppView extends React.Component
  @propTypes:
    entries: React.PropTypes.array
    entry: React.PropTypes.object
    hasNext: React.PropTypes.bool
    searchText: React.PropTypes.string
    searchVisible: React.PropTypes.bool

  constructor: (props) ->
    super props
    @_onEntriesChanged = @_onEntriesChanged.bind @
    @_onEntryChanged = @_onEntryChanged.bind @
    @_onSearchVisibleChanged = @_onSearchVisibleChanged.bind @
    @state =
      entries: props.entries ? getEntryViewer().getAll()
      entry: props.entry ? getEntryViewer().getSelectedEntry()
      hasNext: props.hasNext ? false
      searchText: props.searchText ? getEntryViewer().getSearchText()
      searchVisible: props.searchVisible ? getEntryViewer().getSearchVisible()

  componentDidMount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.addListener 'entries-changed', @_onEntriesChanged
    emitter.addListener 'entry-changed', @_onEntryChanged
    emitter.addListener 'selected', @_onEntryChanged
    emitter.addListener 'search-visible-changed', @_onSearchVisibleChanged

  componentWillUnmount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.removeListener 'entries-changed', @_onEntriesChanged
    emitter.removeListener 'entry-changed', @_onEntryChanged
    emitter.removeListener 'selected', @_onEntryChanged
    emitter.removeListener 'search-visible-changed', @_onSearchVisibleChanged

  render: ->
    React.createElement 'div', id: 'app',
      React.createElement(HeaderView,
        searchText: @state.searchText
        visible: @state.searchVisible
      ),
      React.createElement(ContentView,
        entries: @state.entries
        entry: @state.entry
        hasNext: @state.hasNext
      ),
      React.createElement(FooterView)

  _onEntriesChanged: ({ entries, hasNext }) ->
    @setState
      entries: entries
      entry: null
      hasNext: hasNext
      searchText: @state.searchText
      searchVisible: @state.searchVisible

  _onEntryChanged: (entry) ->
    @setState
      entries: @state.entries
      entry: entry
      hasNext: @state.hasNext
      searchText: @state.searchText
      searchVisible: @state.searchVisible

  _onSearchVisibleChanged: (isVisible) ->
    @setState
      entries: @state.entries
      entry: @state.entry
      hasNext: @state.hasNext
      searchText: @state.searchText
      searchVisible: isVisible

module.exports.AppView = AppView
