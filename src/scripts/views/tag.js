define(['marionette', 'hbs!templates/tag'], function(Marionette, template) {
  return Marionette.ItemView.extend({
    tagName: 'li',

    className: 'tag',

    template: template,

    triggers: {
      'click .name': 'selected:tag'
    },

    templateHelpers: function() {
      var postCount = this.model.get('count');
      return { postCount: function() { return postCount; } };
    },

    onSelectedTag: function(options) {
      var fragment = 'posts?tags=' + options.model.get('name');
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
