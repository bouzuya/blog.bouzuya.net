class RouteService
  @_instance: null

  @getInstance: ->
    @_instance = new RouteService() unless @_instance?
    @_instance

  constructor: ->
    @_histories = []
    @_routes = []

  back: ->
    window.history.back()

  config: (routes) ->
    @_routes = routes

  go: (path) ->
    if @_isBack path
      @back path
    else
      @_forward path

  start: ->
    window.addEventListener 'popstate', =>
      path = window.location.pathname
      if @_isBack path
        @_browserBack path
      else
        @_browserForward path
    hashPath = window.location.hash.substring 1
    path = window.location.pathname
    search = window.location.search
    @_histories.push '/'
    window.history.replaceState { path: '/' }, '', '/'
    if hashPath.length > 0
      @_forward hashPath
    else
      @_forward path + search

  _action: (path = '/') ->
    # console.log "action : #{path}"
    matches = @_routes.map (i) ->
      action: i.action
      params: path.match i.path
    .filter (i) ->
      i.params
    route = matches[0]
    setTimeout ->
      route.action route.params
    , 0

  _browserBack: (path) ->
    @_histories.pop()
    @_action path

  _browserForward: (path) ->
    @_histories.push path
    @_action path

  _forward: (path) ->
    @_histories.push path
    window.history.pushState { path }, '', path
    @_action path

  _isBack: (path) ->
    prev = @_histories[@_histories.length - 2]
    path is prev

  _replace: (path) ->
    @_histories.push path
    window.history.replaceState { path }, '', path
    @_action path

module.exports = ->
  RouteService.getInstance()

module.exports.RouteService = RouteService
