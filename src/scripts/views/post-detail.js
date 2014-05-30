define(['marionette', 'hbs!templates/post-detail'], function(Marionette, template) {
  return Marionette.Layout.extend({
    tagName: 'article',

    className: 'post-detail',

    template: template,

    ui: {
      permalink: '.permalink'
    },

    events: {
      'click @ui.permalink': 'onClickPermalink'
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
    }
  });
});
