define([
  'marionette',
  'hbs!templates/post-tree-date',
  'views/tags'
], function(Marionette, template, TagsView) {
  return Marionette.Layout.extend({
    className: 'post-tree-date',

    template: template,

    templateHelpers: {
      permalink: function() {
        return this.post.date.replace(/-/g, '/') + '/';
      }
    },

    regions: {
      tags: '.tags-region'
    },

    events: {
      'click': 'onClick'
    },

    onShow: function() {
      var post = this.model.get('post');
      this.tags.show(new TagsView({ collection: post.get('tags') }));
    },

    onClick: function() {
      var post = this.model.get('post');
      var fragment = post.get('date').replace(/-/g, '/') + '/';
      Backbone.history.navigate(fragment, { trigger: true });
      return false;
    }
  });
});
