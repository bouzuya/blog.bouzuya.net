define(['marionette', 'hbs!templates/tag'], function(Marionette, template) {
  return Marionette.ItemView.extend({
    tagName: 'li',

    className: 'tag',

    template: template,

    triggers: {
      'click .name': 'selected:tag'
    }
  });
});
