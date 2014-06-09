define([
  'jquery',
  'marionette',
  'hbs!templates/blog',
  'models/post',
  'models/posts-page',
  'collections/posts',
  'collections/tags',
  'backbone-filtered-collection',
  'views/posts-page',
  'views/post-detail',
  'views/tags-page',
  'views/header'
], function($, Marionette, template, Post, PostsPage, Posts, Tags, FilteredCollection, PostsPageView, PostDetailView, TagsPageView, HeaderView) {
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
      this.tags = new Tags();
      this.posts = new Posts();
      this.filtered = new FilteredCollection(this.posts);
      this.app.vent.on('index:post', this.onIndexPost, this);
      this.app.vent.on('show:post', this.onShowPost, this);
      this.app.vent.on('show:post:latest', this.onShowPostLatest, this);
      this.app.vent.on('index:tag', this.onIndexTag, this);
      this.app.vent.on('show:tag', this.onShowTag, this);
      this.app.vent.on('update:title', this.onUpdateTitle, this);
    },

    onShow: function() {
      var headerView = new HeaderView({ model: this.model });
      this.header.show(headerView);
    },

    onIndexPost: function() {
      var model = new PostsPage({ posts: this.posts });
      this.body.show(new PostsPageView({ app: this.app, model: model }));
      this.posts.fetch();
    },

    onShowPost: function(date) {
      this.posts.fetch().then(function() {
        var post = this.posts.findWhere({ date: date });
        var postDetailView = new PostDetailView({ app: this.app, model: post });
        this.listenTo(postDetailView, 'update:title', this.onUpdateTitle);
        this.body.show(postDetailView);
        post.fetch();
      }.bind(this));
    },

    onShowPostLatest: function() {
      this.posts.fetch().then(function() {
        var latest = this.posts.at(0);
        this.body.show(new PostDetailView({
          app: this.app,
          model: latest
        }));
        latest.fetch();
      }.bind(this));
    },

    onIndexTag: function() {
      this.body.show(new TagsPageView({
        app: this.app,
        collection: this.tags
      }));
    },

    onShowTag: function(name) {
      this.tags.reset([{ name: name }]);
      var model = new PostsPage({ tags: this.tags, posts: this.posts });
      this.body.show(new PostsPageView({ app: this.app, model: model }));
      this.posts.fetch();
    },

    onUpdateTitle: function(title) {
      $('title').text(title ? title + ' - blog.bouzuya.net' : 'blog.bouzuya.net');
    }
  });
});
