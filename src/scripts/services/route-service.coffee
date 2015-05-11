class RouteService
  @_instance: null

  @getInstance: ->
    @_instance = new RouteService() unless @_instance?
    @_instance

  constructor: ->

  back: ->

  go: (path) ->

module.exports = ->
  RouteService.getInstance()

module.exports.RouteService = RouteService
