define(['marionette', 'hbs!templates/tag'], function(Marionette, template) {
  return Marionette.ItemView.extend({
    tagName: 'li',

    className: 'tag',

    template: template,

    triggers: {
      'click .name': 'selected:tag'
    },

    onSelectedTag: function(options) {
      var fragment = 'tags/' + options.model.get('name');
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
