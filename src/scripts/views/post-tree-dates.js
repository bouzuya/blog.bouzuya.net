define([
  'marionette',
  'views/post-tree-date'
], function(Marionette, PostTreeDateView) {
  return Marionette.CollectionView.extend({
    className: 'post-tree-dates',

    tagName: 'ul',

    itemView: PostTreeDateView
  });
});
