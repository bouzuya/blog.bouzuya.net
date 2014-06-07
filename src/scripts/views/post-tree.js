define([
  'marionette',
  'hbs!templates/post-tree',
  'collections/post-tree-years',
  'views/post-tree-years'
], function(Marionette, template, PostTreeYears, PostTreeYearsView) {
  return Marionette.Layout.extend({
    className: 'post-tree',

    template: template,

    regions: {
      'years': '.post-tree-years-region'
    },

    collectionEvents: {
      'sync': 'onSync'
    },

    onSync: function(collection) {
      var years = new PostTreeYears(collection, { parse: true });
      this.years.show(new PostTreeYearsView({ collection: years }));
    }
  });
});
