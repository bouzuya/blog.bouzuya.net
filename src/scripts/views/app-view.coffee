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
    query: React.PropTypes.string
    searchVisible: React.PropTypes.bool

  constructor: (props) ->
    super props
    @_onEntriesChanged = @_onEntriesChanged.bind @
    @_onEntryChanged = @_onEntryChanged.bind @
    @_onQueryChanged = @_onQueryChanged.bind @
    @_onSearchVisibleChanged = @_onSearchVisibleChanged.bind @
    @state =
      entries: props.entries ? getEntryViewer().getAll()
      entry: props.entry ? getEntryViewer().getSelectedEntry()
      hasNext: props.hasNext ? false
      query: props.query ? getEntryViewer().getQuery()
      searchVisible: props.searchVisible ? getEntryViewer().getSearchVisible()

  componentDidMount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.addListener 'entries-changed', @_onEntriesChanged
    emitter.addListener 'entry-changed', @_onEntryChanged
    emitter.addListener 'selected', @_onEntryChanged
    emitter.addListener 'query-changed', @_onQueryChanged
    emitter.addListener 'search-visible-changed', @_onSearchVisibleChanged

  componentWillUnmount: ->
    emitter = getEntryViewer().getEventEmitter()
    emitter.removeListener 'entries-changed', @_onEntriesChanged
    emitter.removeListener 'entry-changed', @_onEntryChanged
    emitter.removeListener 'selected', @_onEntryChanged
    emitter.removeListener 'query-changed', @_onQueryChanged
    emitter.removeListener 'search-visible-changed', @_onSearchVisibleChanged

  render: ->
    React.createElement 'div', className: 'app-layout',
      React.createElement(HeaderView,
        query: @state.query
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

  _onEntryChanged: (entry) ->
    @setState
      entry: entry

  _onSearchVisibleChanged: (isVisible) ->
    @setState
      searchVisible: isVisible

  _onQueryChanged: (query) ->
    @setState
      query: query

module.exports.AppView = AppView
