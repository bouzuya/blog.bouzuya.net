define(['marionette', 'views/tags', 'hbs!templates/tags-page'], function(Marionette, TagsView, template) {
  return Marionette.Layout.extend({
    className: 'tags-page',

    template: template,

    regions: {
      tags: '.tags-region'
    },

    collectionEvents: {
      'sync': 'onSync'
    },

    initialize: function(options) {
      this.app = options.app;
    },

    onShow: function() {
      this.app.vent.trigger('update:title', 'tags');
      this.collection.fetch();
    },

    onSync: function() {
      this.collection.sort();
      this.tags.show(new TagsView({ collection: this.collection }));
    }
  });
});
