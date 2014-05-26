define([
  'marionette',
  'hbs!templates/blog',
  'models/post',
  'collections/posts',
  'models/tag',
  'collections/tags',
  'views/posts',
  'views/post-detail',
  'views/tags',
  'views/header'
], function(Marionette, template, Post, Posts, Tag, Tags, PostsView, PostDetailView, TagsView, HeaderView) {
  return Marionette.Layout.extend({
    tagName: 'section',

    className: 'blog',

    template: template,

    regions: {
      header: '.header-region',
      body: '.body-region'
    },

    initialize: function(options) {
      this.app = options.app;
      this.app.vent.on('index:post', this.onIndexPost, this);
      this.app.vent.on('show:post', this.onShowPost, this);
      this.app.vent.on('show:post:latest', this.onShowPostLatest, this);
      this.app.vent.on('index:tag', this.onIndexTag, this);
      this.app.vent.on('show:tag', this.onShowTag, this);
    },

    onShow: function() {
      var headerView = new HeaderView({ model: this.model });
      this.header.show(headerView);
    },

    onIndexPost: function() {
      var posts = new Posts();
      var postsView = new PostsView({ collection: posts });
      this.body.show(postsView);
      posts.fetch();
    },

    onShowPost: function(date) {
      var post = new Post({ date: date });
      var postDetailView = new PostDetailView({ model: post });
      this.body.show(postDetailView);
      post.fetch();
    },

    onShowPostLatest: function() {
      var posts = new Posts();
      posts.fetch().then(function() {
        var latest = posts.at(posts.length - 1);
        var postDetailView = new PostDetailView({ model: latest });
        this.body.show(postDetailView);
        latest.fetch();
      }.bind(this));
    },

    onIndexTag: function() {
      var tags = new Tags();
      var tagsView = new TagsView({ collection: tags });
      this.body.show(tagsView);
      tags.fetch();
    },

    onShowTag: function(name) {
      var tag = new Tag({ name: name });
      var posts = new Posts();
      var postsView = new PostsView({ collection: posts, tags: [tag] });
      this.body.show(postsView);
      posts.fetch();
    }
  });
});
