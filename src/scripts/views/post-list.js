define(['marionette', 'views/post'], function(Marionette, PostView) {
  return Marionette.CollectionView.extend({
    tagName: 'ul',

    className: 'post-list',

    itemView: PostView,

    itemEvents: {
      'selected:post': 'onSelectedPost'
    },

    onSelectedPost: function(eventName, args) {
      var fragment = args.model.get('date') + '/';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
