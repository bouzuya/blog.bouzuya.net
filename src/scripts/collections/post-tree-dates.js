define(['backbone', 'models/post-tree-date'], function(Backbone, PostTreeDate) {
  return Backbone.Collection.extend({ model: PostTreeDate });
});
