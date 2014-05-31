define(['marionette', 'views/tag', 'hbs!templates/tags'], function(Marionette, TagView, template) {
  return Marionette.CompositeView.extend({
    className: 'tags',

    template: template,

    itemViewContainer: 'ul',

    itemView: TagView,

    itemEvents: {
      'selected:tag': 'onSelectedTag'
    },

    onSelectedTag: function(eventName, args) {
      var fragment = 'tags/' + args.model.get('name');
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
