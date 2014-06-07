define([
  'marionette',
  'views/post-tree-month'
], function(Marionette, PostTreeMonthView) {
  return Marionette.CollectionView.extend({
    className: 'post-tree-months',

    tagName: 'ul',

    itemView: PostTreeMonthView
  });
});
