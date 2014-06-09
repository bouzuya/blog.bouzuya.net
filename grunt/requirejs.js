module.exports = {
  compile: {
    options: {
      baseUrl: 'src/scripts/',
      name: 'main',
      out: 'build/scripts/main.js',
      uglify: {
        beautify: true
      },
      paths: {
        'backbone-filtered-collection': 'vendor/backbone-filtered-collection/backbone-filtered-collection',
        'backbone.babysitter' : 'vendor/backbone.babysitter/lib/backbone.babysitter',
        'backbone.wreqr' : 'vendor/backbone.wreqr/lib/backbone.wreqr',
        backbone: 'vendor/backbone/backbone',
        hbs: 'vendor/require-handlebars-plugin/hbs'  ,
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
      }
    }
  }
};
