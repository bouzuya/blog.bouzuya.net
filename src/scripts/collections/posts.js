define(['backbone', 'models/post'], function(Backbone, Post) {
  return Backbone.Collection.extend({
    model: Post,

    url: '/posts.json'
  });
});
