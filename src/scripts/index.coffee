React = require 'react'
{AppView} = require './views/app-view'

window.addEventListener 'DOMContentLoaded', ->
  rootElement = React.createElement AppView
  React.render rootElement, document.body
  setTimeout ->
    console.log '%c   ([:-P   ', 'font-size: 128px; font-family: "Fredoka One"'
  , 1000
