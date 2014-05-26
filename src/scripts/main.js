require.config({
  paths: {
    backbone: 'vendor/backbone/backbone',
    jquery: 'vendor/jquery/dist/jquery',
    marionette: 'vendor/backbone.marionette/lib/backbone.marionette',
    underscore: 'vendor/underscore/underscore',
    hbs: 'vendor/require-handlebars-plugin/hbs'
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
    },
    marionette: {
      deps: ['jquery', 'underscore', 'backbone'],
      exports: 'Marionette'
    }
  }
});

define(['marionette', 'models/blog', 'views/blog', 'routers/blog'], function(Marionette, Blog, BlogView, BlogRouter) {
  var app = new Marionette.Application();

  app.addRegions({ body: 'body' });
  app.addInitializer(function(options) {
    var blog = new Blog();
    options.app.body.show(new BlogView({ app: options.app, model: blog }));
    options.blog = blog;
  });
  app.addInitializer(function(options) {
    new BlogRouter(options); // { app: ..., blog: ... }
    Backbone.history.start();
    // Backbone.history.start({ pushState: true, root: '/' });
  });
  app.start({ app: app });
});
