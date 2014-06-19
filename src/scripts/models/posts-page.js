define(['backbone', 'collections/tags', 'collections/posts'], function(Backbone, Tags, Posts) {
  return Backbone.Model.extend({
    initialize: function(options) {
      options = options || {};
      var tags = options.tags || new Tags();
      var posts = options.posts || new Posts();
      this.set('tags', tags);
      this.set('posts', posts);
    }
  });
});
