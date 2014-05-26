define(['marionette', 'views/tag'], function(Marionette, TagView) {
  return Marionette.CollectionView.extend({
    tagName: 'ul',

    className: 'tags',

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
