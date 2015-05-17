browserify = require 'browserify'
browserSync = require 'browser-sync'
buffer = require 'vinyl-buffer'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
del = require 'del'
espower = require 'gulp-espower'
gulp = require 'gulp'
gutil = require 'gulp-util'
less = require 'gulp-less'
minifyCss = require 'gulp-minify-css'
mocha = require 'gulp-mocha'
run = require 'run-sequence'
source = require 'vinyl-source-stream'
sourcemaps = require 'gulp-sourcemaps'
uglify = require 'gulp-uglify'
watch = require 'gulp-watch'

ignoreError = (stream) ->
  stream.on 'error', (e) ->
    gutil.log e
    @emit 'end'

gulp.task 'prerender', ->
  React = require 'react'
  {AppView} = require './src/scripts/views/app-view'
  prerender = (file, entry) ->
    props =
      entries: [entry].filter (i) -> i
      entry: entry
      hasNext: false
      searchText: null # entry?.date ? null
      searchVisible: false # entry?
    title = (if entry? then entry.title + ' - ' else '') + 'blog.bouzuya.net'
    doctype = '<!DOCTYPE html>'
    html = React.renderToStaticMarkup React.DOM.html null,
      React.DOM.head null,
        React.DOM.meta(charSet: 'UTF-8')
        React.DOM.meta(name: 'viewport', content: [
          'width=device-width'
          'initial-scale=1.0'
          'minimum-scale=1.0'
          'maximum-scale=1.0'
          'user-scalable=no'
        ].join ',')
        React.DOM.title(null, title)
        React.DOM.link(rel: 'stylesheet', href: '/styles/main.css')
        React.DOM.link(rel: 'stylesheet', href: '/styles/font-awesome.min.css')
        React.DOM.script(
          dangerouslySetInnerHTML:
            __html: 'var INITIAL_PROPS=' + JSON.stringify(props) + ';'
        )
        React.DOM.script(src: '/scripts/main.js')
      React.DOM.body null,
        React.DOM.div
          id: 'app-container'
          dangerouslySetInnerHTML:
            __html: React.renderToString(React.createFactory(AppView)(props))
    fse = require 'fs-extra'
    fse.outputFileSync file, doctype + html

  baseDir = './dist/'
  # TODO
  prerender(baseDir + path, entry) for { path, entry } in [
    path: '2015/05/01/index.html'
    entry:
      date: '2015-05-01'
      tags: []
      title: 'ふがー'
      content: 'ほげー'
  ,
    path: '2015/05/02/index.html'
    entry:
      date: '2015-05-02'
      tags: []
      title: 'ふがふがー'
      content: 'ほげほげー'
  ].concat [
    path: 'index.html'
    entry: null
  ]

gulp.task 'build', ['build-resource', 'build-script', 'build-style']

gulp.task 'build-dev', ['build-resource', 'build-script-dev', 'build-style-dev']

gulp.task 'build-font', ->
  gulp.src [
    './node_modules/font-awesome/fonts/*-webfont*'
  ]
  .pipe gulp.dest './dist/fonts/'

gulp.task 'build-html', ->
  gulp.src './src/index.html'
  .pipe gulp.dest './dist/'

gulp.task 'build-resource', ['build-font', 'build-html'], ->
  gulp.src [
    './node_modules/font-awesome/css/font-awesome.min.css'
  ]
  .pipe gulp.dest './dist/styles/'

gulp.task 'build-script', (done) ->
  run.apply run, [
    'build-script-coffee'
    'build-script-browserify'
    done
  ]
  null

gulp.task 'build-script-dev', (done) ->
  run.apply run, [
    'build-script-coffee-dev'
    'build-script-browserify-dev'
    done
  ]
  null

gulp.task 'build-script-browserify', ->
  bundled = browserify
    debug: false
  .add './.tmp/src/scripts/index.js'
  .bundle()
  bundled
  .pipe source 'main.js'
  .pipe buffer()
  .pipe uglify()
  .pipe gulp.dest './dist/scripts/'

gulp.task 'build-script-browserify-dev', ->
  bundled = browserify
    debug: true
  .add './.tmp/src/scripts/index.js'
  .bundle()
  ignoreError bundled
  .pipe source 'main.js'
  .pipe buffer()
  .pipe gulp.dest './dist/scripts/'

gulp.task 'build-script-coffee', ->
  gulp.src './src/scripts/**/*.coffee'
  .pipe coffee()
  .pipe gulp.dest './.tmp/src/scripts/'

gulp.task 'build-script-coffee-dev', ->
  gulp.src './src/scripts/**/*.coffee'
  .pipe sourcemaps.init()
  .pipe ignoreError coffee()
  .pipe sourcemaps.write()
  .pipe gulp.dest './.tmp/src/scripts/'

gulp.task 'build-style', ->
  gulp.src './src/styles/**/*.less'
  .pipe less()
  .pipe concat 'main.css'
  .pipe minifyCss()
  .pipe gulp.dest './dist/styles/'

gulp.task 'build-style-dev', ->
  gulp.src './src/styles/**/*.less'
  .pipe ignoreError less()
  .pipe concat 'main.css'
  .pipe minifyCss()
  .pipe gulp.dest './dist/styles/'

gulp.task 'build-test', ->
  gulp.src './test/**/*.coffee'
  .pipe sourcemaps.init()
  .pipe coffee()
  .pipe espower()
  .pipe sourcemaps.write()
  .pipe gulp.dest './.tmp/test/'

gulp.task 'build-test-dev', ->
  gulp.src './test/**/*.coffee'
  .pipe sourcemaps.init()
  .pipe ignoreError coffee()
  .pipe ignoreError espower()
  .pipe sourcemaps.write()
  .pipe gulp.dest './.tmp/test/'

gulp.task 'clean', (done) ->
  del [
    './.tmp/'
    './dist/'
  ], done
  null

gulp.task 'default', ['clean', 'build']

gulp.task 'test', ['build-test'], ->
  gulp.src './.tmp/test/**/*.js'
  .pipe mocha()

gulp.task 'test-dev', ['build-test-dev'], ->
  gulp.src './.tmp/test/**/*.js'
  .pipe ignoreError mocha()

gulp.task 'watch', ['build-dev'], ->
  browserSync
    server:
      baseDir: './dist/'

  watch './src/index.html', ->
    run.apply run, [
      'build-resource'
      ->
        browserSync.reload()
    ]

  watch [
    './src/**/*.coffee'
    './test/**/*.coffee'
  ], ->
    run.apply run, [
      'build-dev'
      'test-dev'
      ->
        browserSync.reload()
    ]

  watch [
    './src/styles/**/*.less'
  ], ->
    run.apply run, [
      'build-style-dev'
      ->
        browserSync.reload()
    ]
