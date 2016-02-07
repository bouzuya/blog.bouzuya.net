moment = require 'moment'
React = require 'react'
fse = require 'fs-extra'
ServerReactRootIndex = require 'react/lib/ServerReactRootIndex'
{AppView} = require './src/scripts/views/app-view'

# hack for generating same react id
ServerReactRootIndex.createReactRootIndex = ->
  0

buildBody = (props) ->
  React.DOM.body(
    null
    React.DOM.div
      id: 'app-container'
      dangerouslySetInnerHTML:
        __html: React.renderToString(React.createFactory(AppView)(props))
    React.DOM.script(src: '/scripts/main.js')
  )

buildHead = (props) ->
  entry = props.entry
  titlePrefix = if entry?
    date = moment(entry.pubdate).format 'YYYY-MM-DD'
    date + ' ' + entry.title + ' - '
  else
    ''
  title = titlePrefix + 'blog.bouzuya.net'
  React.DOM.head(
    null
    React.DOM.meta(charSet: 'UTF-8')
    React.DOM.meta(name: 'robots', content: 'index, follow')
    React.DOM.meta(name: 'viewport', content: [
      'width=device-width'
      'initial-scale=1.0'
      'minimum-scale=1.0'
      'maximum-scale=1.0'
      'user-scalable=no'
    ].join ',')
    React.DOM.title(null, title)
    React.DOM.link(
      rel: 'icon'
      href: '/images/favicon.png'
      type: 'image/png'
    )
    React.DOM.link(rel: 'stylesheet', href: '/styles/main.css')
    React.DOM.script(
      dangerouslySetInnerHTML:
        __html: '''
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-42111132-2', 'bouzuya.net');
ga('send', 'pageview');
        '''
    )
    React.DOM.script(
      dangerouslySetInnerHTML:
        __html: "//<!--\nvar INITIAL_PROPS=#{JSON.stringify(props)};\n//-->"
    )
  )

buildHtml = (props) ->
  React.DOM.html(
    null
    buildHead(props)
    buildBody(props)
  )

buildHtmlAsString = (props) ->
  doctype = '<!DOCTYPE html>'
  html = React.renderToStaticMarkup buildHtml(props)
  doctype + html

prerender = (file, entry) ->
  props =
    entries: [entry].filter (i) -> i
    entry: entry
    hasNext: false
    searchText: null # entry?.date ? null
    searchVisible: false # entry?
  fse.outputFileSync file, buildHtmlAsString(props)

module.exports = prerender
