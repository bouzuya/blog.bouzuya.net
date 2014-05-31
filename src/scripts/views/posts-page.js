define(['marionette', 'hbs!templates/posts-page', 'views/posts', 'views/tags'], function(Marionette, template, PostsView, TagsView) {
  return Marionette.Layout.extend({
    className: 'posts-page',

    template: template,

    regions: {
      tags: '.tags-region',
      posts: '.posts-region'
    },

    onShow: function() {
      if (this.model.get('tags')) {
        this.tags.show(new TagsView({ collection: this.model.get('tags') }));
      }
      this.posts.show(new PostsView({
        collection: this.model.get('posts'),
        tags: this.model.get('tags')
      }));
      this.model.get('posts').fetch();
    }
  });
});
