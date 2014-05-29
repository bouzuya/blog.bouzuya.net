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

    triggers: {
      'click .date': 'selected:post',
    }
  });
});
