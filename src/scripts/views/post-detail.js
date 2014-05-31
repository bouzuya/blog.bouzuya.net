define(['marionette', 'hbs!templates/post-detail', 'views/tags'], function(Marionette, template, TagsView) {
  return Marionette.Layout.extend({
    tagName: 'article',

    className: 'post-detail',

    template: template,

    regions: {
      tags: '.tags-region'
    },

    ui: {
      permalink: '.permalink'
    },

    events: {
      'click @ui.permalink': 'onClickPermalink',
    },

    templateHelpers: {
      permalink: function() {
        return this.date.replace(/-/g, '/') + '/';
      }
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
      var fragment = this.model.get('date');
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
