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
      if (tags) {
        var filtered = new FilteredCollection(posts);
        filtered.filterBy(function(p) { return p.hasTags(tags); });
        this.tags.show(new TagsView({ collection: tags }));
        this.posts.show(new PostListView({ collection: filtered }));
      } else {
        this.posts.show(new PostTreeView({ collection: posts }));
      }
      posts.fetch();
    }
  });
});
