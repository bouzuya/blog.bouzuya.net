define(['backbone', 'collections/tags'], function(Backbone, Tags) {
  return Backbone.Model.extend({
    defaults: {
      date: null,
      pubdate: null,
      title: null,
      tags: null, // collections/tags
      html: null
      // date: '1970-01-01',
      // pubdate: '1970-01-01T00:00:00+09:00',
      // title: 'no title',
      // tags: ['misc'],
      // html: null
    },

    idAttribute: 'date',

    url: function() {
      return '/posts/' + this.get('date') + '.json';
    },

    parse: function(data) {
      data.tags = new Tags(data.tags, { parse: true });
      return data;
    },

    hasTags: function(queryTags) {
      var modelTagNames = this.get('tags').pluck('name');
      var queryTagNames = queryTags.pluck('name');
      return queryTagNames.every(function(tagName) {
        return modelTagNames.indexOf(tagName) >= 0;
      });
    },

    path: function() {
      return '/' + this.get('date').replace(/-/g, '/') + '/';
    },

    olderPath: function() {
      var col = this.collection;
      var idx = col.indexOf(this);
      return (idx + 1 < col.length ? col.at(idx + 1).path() : null);
    },

    newerPath: function() {
      var col = this.collection;
      var idx = col.indexOf(this);
      return (idx - 1 >= 0 ? col.at(idx - 1).path() : null);
    }
  });
});
