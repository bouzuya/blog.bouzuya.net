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

    onShow: function() {
      this.collection.fetch();
    },

    onSync: function() {
      this.tags.show(new TagsView({ collection: this.collection }));
    }
  });
});
