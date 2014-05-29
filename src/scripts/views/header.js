define(['marionette', 'hbs!templates/header'], function(Marionette, template) {
  return Marionette.ItemView.extend({
    className: 'header',

    template: template,

    ui: {
      title: '.title',
      menuButton: 'nav .menu-button',
      menu: 'nav .menu',
      postsLink: 'nav a[href^="/posts"]',
      tagsLink: 'nav a[href^="/tags"]'
    },

    events: {
      'click @ui.title': 'onClickTitle',
      'click @ui.menuButton': 'onClickMenuButton',
      'click @ui.postsLink': 'onClickPostsLink',
      'click @ui.tagsLink': 'onClickTagsLink'
    },

    onClickTitle: function() {
      var fragment = '';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    },

    onClickMenuButton: function() {
      this.ui.menu.toggle();
      return false;
    },

    onClickPostsLink: function() {
      this.ui.menu.toggle();
      var fragment = 'posts';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    },

    onClickTagsLink: function() {
      this.ui.menu.toggle();
      var fragment = 'tags';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
