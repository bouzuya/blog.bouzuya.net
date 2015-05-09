React = require 'react'
{AppView} = require './views/app-view'

window.addEventListener 'DOMContentLoaded', ->
  rootElement = React.createElement AppView
  React.render rootElement, document.body
