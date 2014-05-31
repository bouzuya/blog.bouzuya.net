define(['marionette', 'hbs!templates/post'], function(Marionette, template) {
  return Marionette.ItemView.extend({
    tagName: 'li',

    className: 'post',

    template: template,

    templateHelpers: {
      permalink: function() {
        return this.date.replace(/-/g, '/') + '/';
      }
    },

    ui: {
      permalink: '.date, .title',
      tagLink: '.tag a'
    },

    triggers: {
      'click @ui.permalink': 'selected:post',
    },

    events: {
      'click @ui.tagLink': 'onClickTagLink'
    },

    onClickTagLink: function(e) {
      var fragment = $(e.currentTarget).attr('href');
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
