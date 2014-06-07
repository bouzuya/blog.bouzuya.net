define(['backbone', 'models/post-tree-month'], function(Backbone, PostTreeMonth) {
  return Backbone.Collection.extend({ model: PostTreeMonth });
});
