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
      var model = new PostsPage();
      this.body.show(new PostsPageView({ app: this.app, model: model }));
    },

    onShowPost: function(date) {
      var post = new Post({ date: date });
      var postDetailView = new PostDetailView({ app: this.app, model: post });
      this.listenTo(postDetailView, 'update:title', this.onUpdateTitle);
      this.body.show(postDetailView);
      post.fetch();
    },

    onShowPostLatest: function() {
      this.app.vent.trigger('update:title');
      var posts = new Posts();
      posts.fetch().then(function() {
        var latest = posts.at(posts.length - 1);
        var postDetailView = new PostDetailView({ app: this.app, model: latest });
        this.body.show(postDetailView);
        latest.fetch();
      }.bind(this));
    },

    onIndexTag: function() {
      var tags = new Tags();
      var tagsPageView = new TagsPageView({ app: this.app, collection: tags });
      this.body.show(tagsPageView);
    },

    onShowTag: function(name) {
      var model = new PostsPage({ tagName: name });
      this.body.show(new PostsPageView({ app: this.app, model: model }));
    },

    onUpdateTitle: function(title) {
      $('title').text(title ? title + ' - blog.bouzuya.net' : 'blog.bouzuya.net');
    }
  });
});
