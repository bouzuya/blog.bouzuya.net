define([
  'backbone',
  'collections/post-tree-months'
], function(Backbone, PostTreeMonths) {
  return Backbone.Model.extend({
    idAttribute: 'year',

    initialize: function() {
      this.set('months', new PostTreeMonths());
    }
  });
});
