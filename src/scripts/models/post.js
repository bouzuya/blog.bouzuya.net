define(['backbone'], function(Backbone) {
  return Backbone.Model.extend({
    defaults: {
      date: null,
      pubdate: null,
      title: null,
      tags: [],
      html: null
      // date: '1970-01-01',
      // pubdate: '1970-01-01T00:00:00+09:00',
      // title: 'no title',
      // tags: ['misc'],
      // html: null
    },

    url: function() {
      return '/posts/' + this.get('date') + '.json';
    },

    hasTags: function(tags) {
      var modelTagNames = this.get('tags');
      return tags.every(function(tag) {
        var tagName = tag.get('name');
        return modelTagNames.some(function(modelTagName) {
          return modelTagName === tagName;
        });
      });
    }
  });
});
