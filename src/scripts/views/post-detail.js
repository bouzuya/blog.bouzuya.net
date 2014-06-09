define(['marionette', 'hbs!templates/post-detail', 'views/tags'], function(Marionette, template, TagsView) {
  return Marionette.Layout.extend({
    tagName: 'article',

    className: 'post-detail',

    template: template,

    regions: {
      tags: '.tags-region'
    },

    ui: {
      permalink: '.permalink',
      olderLink: '.older',
      newerLink: '.newer',
    },

    events: {
      'click @ui.permalink': 'onClickPermalink',
      'click @ui.olderLink': 'onClickOlderLink',
      'click @ui.newerLink': 'onClickNewerLink'
    },

    templateHelpers: function() {
      var path = this.model.path();
      var olderPath = this.model.olderPath();
      var newerPath = this.model.newerPath();
      return {
        permalink: function() { return path; },
        older: function() { return olderPath; },
        newer: function() { return newerPath; }
      };
    },

    modelEvents: {
      'sync': 'onSync'
    },

    initialize: function(options) {
      this.app = options.app;
    },

    onSync: function() {
      this.app.vent.trigger('update:title', this.model.get('title'));
      this.render();
      this.tags.show(new TagsView({ collection: this.model.get('tags') }));
    },

    onClickPermalink: function() {
      var fragment = this.model.path();
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    },

    onClickOlderLink: function() {
      var fragment = this.model.olderPath();
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    },

    onClickNewerLink: function() {
      var fragment = this.model.newerPath();
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
