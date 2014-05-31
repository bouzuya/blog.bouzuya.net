define(['backbone', 'collections/tags', 'collections/posts'], function(Backbone, Tags, Posts) {
  return Backbone.Model.extend({
    initialize: function(options) {
      options = options || {};
      var tags = options.tagName ? new Tags([options.tagName], { parse: true }) : null;
      var posts = new Posts();
      this.set('tags', tags);
      this.set('posts', posts);
    }
  });
});
