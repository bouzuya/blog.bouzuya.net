define(['backbone', 'models/post'], function(Backbone, Post) {
  return Backbone.Collection.extend({
    model: Post,

    comparator: function(a, b) {
      var aDate = a.get('date');
      var bDate = b.get('date');
      return aDate === bDate ? 0 : aDate > bDate ? -1 : 1;
    },

    url: '/posts.json'
  });
});
