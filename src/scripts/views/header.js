define(['marionette', 'hbs!templates/header'], function(Marionette, template) {
  return Marionette.ItemView.extend({
    className: 'header',

    template: template,

    ui: {
      title: '.title',
      postsLink: 'nav a[href^="/posts"]',
      tagsLink: 'nav a[href^="/tags"]'
    },

    events: {
      'click @ui.title': 'onClickTitle',
      'click @ui.postsLink': 'onClickPostsLink',
      'click @ui.tagsLink': 'onClickTagsLink'
    },

    onClickTitle: function() {
      Backbone.history.navigate('', { trigger: true });
      return false;
    },

    onClickPostsLink: function() {
      var fragment = 'posts';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    },

    onClickTagsLink: function() {
      var fragment = 'tags';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
