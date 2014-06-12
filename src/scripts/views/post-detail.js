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
      var older = this.model.older();
      var newer = this.model.newer();
      var olderPath = older ? older.path() : null;
      var newerPath = newer ? newer.path() : null;
      var olderTitle = older ? older.get('title') : null;
      var newerTitle = newer ? newer.get('title') : null;
      var olderDate = older ? older.get('date') : null;
      var newerDate = newer ? newer.get('date') : null;
      return {
        permalink: function() { return path; },
        olderPath: function() { return olderPath; },
        newerPath: function() { return newerPath; },
        olderTitle: function() { return olderTitle; },
        newerTitle: function() { return newerTitle; },
        olderDate: function() { return olderDate; },
        newerDate: function() { return newerDate; }
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
