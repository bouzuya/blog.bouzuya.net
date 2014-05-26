define(['marionette', 'hbs!templates/post'], function(Marionette, template) {
  return Marionette.ItemView.extend({
    tagName: 'li',

    className: 'post',

    template: template,

    triggers: {
      'click .date': 'selected:post'
    }
  });
});
