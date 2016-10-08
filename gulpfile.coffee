{exec} = require 'child_process'
{Promise} = require 'es6-promise'
borage = require 'borage'
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
prerender = require './prerender'

loadEntriesV3 = (src) ->
  myjekyll = require 'myjekyll'
  moment = require 'moment'
  marked = require 'marked'
  site = myjekyll src, {}
  site.entries().map (entry) ->
    titleKey = entry.file.match(/^\d+-\d+-\d+-(.+)$/, '$1')[1]
    entry =
      content: marked entry.content
      date: moment(entry.pubdate).format 'YYYY-MM-DD'
      description: entry.content.substring(0, 100)
      file: entry.file
      minutes: entry.minutes
      pubdate: entry.pubdate
      tags: entry.tags
      title: entry.title
      titleKey: titleKey
    entry

prerenderEntry = (entry) ->
  dir = moment(entry.pubdate).format 'YYYY/MM/DD'
  titleKey = entry.titleKey
  paths = [
    dir + '/' + titleKey + '/index.html'
    if titleKey is 'diary' then null else dir + '/diary/index.html'
    dir + '/index.html'
  ].filter (i) -> i
  paths.forEach (path) ->
    prerender(baseDir + path, entry)

ignoreError = (stream) ->
  stream.on 'error', (e) ->
    gutil.log e
    @emit 'end'

gulp.task 'build', (done) ->
  run.apply run, [
    'build-json'
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
  baseDir = './dist/'
  loadEntriesV3('./data/**/*.md').forEach (entry) ->
    prerenderEntry(baseDir, entry)
  prerender(baseDir + 'index.html', null)

gulp.task 'build-images', ->
  gulp.src './src/images/*'
  .pipe gulp.dest './dist/images'

gulp.task 'build-json', (done) ->
  exec '$(npm bin)/kraken', (err, stdout, stderr) ->
    return done(err) if err?
    console.log stdout if stdout?.length > 0
    console.error stderr if stderr?.length > 0
    done()

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

gulp.task 'clean', (done) ->
  del [
    './.tmp/'
    './dist/'
  ], done
  null

gulp.task 'deploy', ['build'], ->
  borage './dist/**/*',
    root: './dist'
    bucketName: 'blog.bouzuya.net'
    verbose: true

gulp.task 'test', ['build-test'], ->
  gulp.src './.tmp/test/**/*.js'
  .pipe mocha()
