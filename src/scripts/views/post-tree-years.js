define([
  'marionette',
  'views/post-tree-year'
], function(Marionette, PostTreeYearView) {
  return Marionette.CollectionView.extend({
    className: 'post-tree-years',

    tagName: 'ul',

    itemView: PostTreeYearView
  });
});
