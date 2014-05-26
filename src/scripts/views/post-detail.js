define(['marionette', 'hbs!templates/post-detail'], function(Marionette, template) {
  return Marionette.Layout.extend({
    tagName: 'article',

    className: 'post-detail',

    template: template,

    modelEvents: {
      'sync': 'onSync'
    },

    onSync: function() {
      this.render();
    }
  });
});
