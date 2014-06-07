define([
  'marionette',
  'hbs!templates/posts-page',
  'views/post-list',
  'views/post-tree',
  'views/tags'
], function(Marionette, template, PostListView, PostTreeView, TagsView) {
  return Marionette.Layout.extend({
    className: 'posts-page',

    template: template,

    regions: {
      tags: '.tags-region',
      posts: '.posts-region'
    },

    initialize: function(options) {
      this.app = options.app;
    },

    onShow: function() {
      this.app.vent.trigger('update:title', 'posts');
      if (this.model.get('tags')) {
        this.tags.show(new TagsView({ collection: this.model.get('tags') }));
        this.posts.show(new PostListView({
          collection: this.model.get('posts'),
          tags: this.model.get('tags')
        }));
      } else {
        this.posts.show(new PostTreeView({
          collection: this.model.get('posts')
        }));
      }
      this.model.get('posts').fetch().then(function() {
        this.model.get('posts').trigger('reset'); // re-render
      }.bind(this));
    }
  });
});
