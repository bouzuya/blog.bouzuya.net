define([
  'backbone',
  'collections/post-tree-dates'
], function(Backbone, PostTreeDates) {
  return Backbone.Model.extend({
    idAttribute: 'month',

    initialize: function() {
      if (!this.has('dates')) {
        this.set('dates', new PostTreeDates());
      }
    }
  });
});
