define(['marionette', 'hbs!templates/post-detail'], function(Marionette, template) {
  return Marionette.Layout.extend({
    tagName: 'article',

    className: 'post-detail',

    template: template,

    ui: {
      permalink: '.permalink',
      tagLink: '.tag a'
    },

    events: {
      'click @ui.permalink': 'onClickPermalink',
      'click @ui.tagLink': 'onClickTagLink'
    },

    templateHelpers: {
      permalink: function() {
        return this.date.replace(/-/g, '/') + '/';
      }
    },

    modelEvents: {
      'sync': 'onSync'
    },

    onSync: function() {
      this.render();
    },

    onClickPermalink: function() {
      var fragment = this.model.get('date');
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    },

    onClickTagLink: function(e) {
      var fragment = $(e.currentTarget).attr('href');
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
