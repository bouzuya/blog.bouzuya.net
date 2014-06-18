define([
  'jquery',
  'marionette',
  'hbs!templates/blog',
  'models/post',
  'models/posts-page',
  'collections/posts',
  'collections/tags',
  'views/posts-page',
  'views/post-detail',
  'views/tags-page',
  'views/header'
], function($, Marionette, template, Post, PostsPage, Posts, Tags, PostsPageView, PostDetailView, TagsPageView, HeaderView) {
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
      this.listenTo(this.posts, 'sync', this.onSync);
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
      this.fetch = this.posts.fetch();
    },

    onIndexPost: function() {
      this.fetch.then(function() {
        console.log(this.posts.length);
        var model = new PostsPage({ posts: this.posts });
        this.body.show(new PostsPageView({ app: this.app, model: model }));
      }.bind(this));
    },

    onShowPost: function(date) {
      this.fetch.then(function() {
        var post = this.posts.findWhere({ date: date });
        var postDetailView = new PostDetailView({ app: this.app, model: post });
        this.listenTo(postDetailView, 'update:title', this.onUpdateTitle);
        this.body.show(postDetailView);
        post.fetch();
      }.bind(this));
    },

    onShowPostLatest: function() {
      this.fetch.then(function() {
        var post = this.posts.at(0);
        var postDetailView = new PostDetailView({ app: this.app, model: post });
        this.listenTo(postDetailView, 'update:title', this.onUpdateTitle);
        this.body.show(postDetailView);
        post.fetch();
      }.bind(this));
    },

    onIndexTag: function() {
      this.fetch.then(function() {
        this.body.show(new TagsPageView({
          app: this.app,
          collection: this.tags
        }));
      }.bind(this));
    },

    onShowTag: function(name) {
      this.fetch.then(function() {
        this.tags.reset([{ name: name }]);
        var model = new PostsPage({ tags: this.tags, posts: this.posts });
        this.body.show(new PostsPageView({ app: this.app, model: model }));
      }.bind(this));
    },

    onUpdateTitle: function(title) {
      $('title').text(title ? title + ' - blog.bouzuya.net' : 'blog.bouzuya.net');
    }
  });
});
