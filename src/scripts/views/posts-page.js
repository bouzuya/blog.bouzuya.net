define([
  'marionette',
  'hbs!templates/posts-page',
  'backbone-filtered-collection',
  'views/post-list',
  'views/post-tree',
  'views/tags'
], function(Marionette, template, FilteredCollection, PostListView, PostTreeView, TagsView) {
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
      var posts = this.model.get('posts');
      var tags = this.model.get('tags');
      var style = this.model.get('style');
      if (style === 'tree') {
        this.posts.show(new PostTreeView({ collection: posts }));
      } else {
        var filtered = new FilteredCollection(posts);
        filtered.filterBy(function(post) { return post.hasTags(tags); });
        this.tags.show(new TagsView({ collection: tags }));
        this.posts.show(new PostListView({ collection: filtered }));
      }
    }
  });
});
