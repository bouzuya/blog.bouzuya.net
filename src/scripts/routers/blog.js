define(['backbone', 'marionette'], function(Backbone, Marionette) {
  return Marionette.AppRouter.extend({
    initialize: function(options) {
      var routes = [
        { eventName: 'index:post', pattern: 'posts', aliases: ['entries'] },
        { eventName: 'show:post', pattern: /^(\d{4})[-/](\d{2})[-/](\d{2}).*$/,
          callback: function(year, month, date) {
            return {
              pattern: [year, month, date].join('/') + '/',
              args: [[year, month, date].join('-')]
            };
          }
        },
        { eventName: 'index:tag', pattern: 'tags' },
        { eventName: 'show:tag', pattern: 'tags/:name',
          callback: function(name) {
            return { pattern: 'tags/' + name, args: [name] };
          }
        },
        { eventName: 'show:post:latest', pattern: '' }
      ];

      this.app = options.app;

      routes.forEach(function(route) {

        var callback = function() {
          var eventName = route.eventName;
          var pattern = route.pattern;
          var args = Array.prototype.slice.call(arguments);
          if (route.callback) {
            var r = route.callback.apply(route, args);
            eventName = r.eventName || eventName;
            pattern = r.pattern || pattern;
            args = r.args || args;
          }
          Backbone.history.navigate(pattern, { replace: true });
          this.app.vent.trigger.apply(this.app.vent, [eventName].concat(args));
        };

        this.route(route.pattern, callback);
        (route.aliases || []).forEach(function(alias) {
          this.route(alias, callback);
        }, this);

      }, this);
    },
  });
});
