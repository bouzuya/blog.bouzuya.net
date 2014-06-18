(function() {
  'use strict';

  // http://karma-runner.github.io/0.6/plus/RequireJS.html
  require.config({
    baseUrl: '/base/src/scripts',
    deps: [
      '/base/test/collections/posts.js'
    ],
    paths: {
      // test
      mocha: 'vendor/mocha/mocha',
      chai: 'vendor/chai/chai',
      'sinon-chai': 'vendor/sinon-chai/lib/sinon-chai',
      // main
      'backbone-filtered-collection':
        'vendor/backbone-filtered-collection/backbone-filtered-collection',
      'backbone.babysitter':
        'vendor/backbone.babysitter/lib/backbone.babysitter',
      'backbone.wreqr': 'vendor/backbone.wreqr/lib/backbone.wreqr',
      backbone: 'vendor/backbone/backbone',
      hbs: 'vendor/require-handlebars-plugin/hbs',
      jquery: 'vendor/jquery/dist/jquery',
      marionette: 'vendor/backbone.marionette/lib/core/amd/backbone.marionette',
      underscore: 'vendor/underscore/underscore'
    },
    shim: {
      jquery: {
        exports: 'jQuery'
      },
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      }
    },
    callback: window.__karma__.start
  });

})();
