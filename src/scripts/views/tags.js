define(['marionette', 'views/tag', 'hbs!templates/tags'], function(Marionette, TagView, template) {
  return Marionette.CompositeView.extend({
    className: 'tags',

    template: template,

    itemViewContainer: 'ul',

    itemView: TagView
  });
});
