define(['marionette', 'hbs!templates/post', 'views/tags'], function(Marionette, template, TagsView) {
  return Marionette.Layout.extend({
    tagName: 'li',

    className: 'post',

    template: template,

    templateHelpers: {
      permalink: function() {
        return this.date.replace(/-/g, '/') + '/';
      }
    },

    regions: {
      tags: '.tags-region'
    },

    ui: {
      permalink: '.date, .title',
      tagLink: '.tag a'
    },

    triggers: {
      'click @ui.permalink': 'selected:post',
    },

    onShow: function() {
      this.tags.show(new TagsView({ collection: this.model.get('tags') }));
    }
  });
});
