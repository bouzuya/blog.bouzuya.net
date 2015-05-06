assert = require 'power-assert'
{App} = require '../src/scripts/app'

describe 'App', ->
  it 'works', ->
    assert typeof App is 'function'
