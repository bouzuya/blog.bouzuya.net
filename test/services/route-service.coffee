assert = require 'power-assert'
{RouteService} = require '../../src/scripts/services/route-service'

describe 'RouteService', ->
  beforeEach ->
    @service = new RouteService()

  describe '#go', ->
    it 'should be defined as function', ->
      assert typeof @service.go is 'function'

  describe '#back', ->
    it 'should be defined as function', ->
      assert typeof @service.back is 'function'
