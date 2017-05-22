borage = require '@bouzuya/borage'
kraken = require '@bouzuya/kraken'
{exec} = require 'child_process'
{Promise} = require 'es6-promise'
browserSync = require 'browser-sync'
browserify = require 'browserify'
buffer = require 'vinyl-buffer'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
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
prerender = require './prerender'

loadEntriesV4 = ->
  inDir = './data'
  kraken.load(inDir).map (entry) ->
    content: entry.html
    date: entry.date
    description: entry.data.substring(0, 100)
    minutes: entry.minutes
    pubdate: entry.pubdate
    tags: entry.tags
    title: entry.title
    titleKey: entry.id.title ? 'diary'

ignoreError = (stream) ->
  stream.on 'error', (e) ->
    gutil.log e
    @emit 'end'

gulp.task 'build', (done) ->
  run.apply run, [
    [
      'build-html'
      'build-resource'
      'build-script'
      'build-style'
    ]
    done
  ]

gulp.task 'build-font', ->
  gulp.src [
    './node_modules/font-awesome/fonts/*-webfont*'
  ]
  .pipe gulp.dest './dist/fonts/'

gulp.task 'build-html', ->
  entries = loadEntriesV4()
  prerender(entries)

gulp.task 'build-images', ->
  gulp.src './src/images/*'
  .pipe gulp.dest './dist/images'

gulp.task 'build-resource', [
  'build-font'
  'build-images'
  'build-robots-txt'
]

gulp.task 'build-robots-txt', ->
  gulp.src './src/robots.txt'
  .pipe gulp.dest './dist/'

gulp.task 'build-script', (done) ->
  run.apply run, [
    'build-script-coffee'
    'build-script-browserify'
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

gulp.task 'build-script-coffee', ->
  gulp.src './src/scripts/**/*.coffee'
  .pipe coffee()
  .pipe gulp.dest './.tmp/src/scripts/'

gulp.task 'build-style', ->
  gulp.src [
    './src/styles/**/*.less'
    './node_modules/font-awesome/css/font-awesome.min.css'
  ]
  .pipe less()
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

gulp.task 'deploy', ->
  borage './dist/**/*',
    root: './dist'
    bucketName: 'blog.bouzuya.net'
    verbose: true

gulp.task 'test', ['build-test'], ->
  gulp.src './.tmp/test/**/*.js'
  .pipe mocha()
