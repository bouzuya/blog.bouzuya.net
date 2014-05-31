define(['marionette', 'hbs!templates/posts', 'views/post'], function(Marionette, template, PostView) {
  return Marionette.CollectionView.extend({
    tagName: 'ul',

    className: 'posts',

    itemView: PostView,

    itemEvents: {
      'selected:post': 'onSelectedPost'
    },

    initialize: function(options) {
      this.tags = options.tags;
    },

    onSelectedPost: function(eventName, args) {
      var fragment = args.model.get('date') + '/';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    },

    // overrides addItemView for filtering by tags
    addItemView: function(post) {
      if (!this.tags || post.hasTags(this.tags)) {
        var args = Array.prototype.slice.call(arguments);
        Marionette.CollectionView.prototype.addItemView.apply(this, args);
      }
    }
  });
});
