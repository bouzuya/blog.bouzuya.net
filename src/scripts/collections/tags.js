define(['backbone', 'models/tag'], function(Backbone, Tag) {
  return Backbone.Collection.extend({
    model: Tag,

    url: '/tags.json',

    parse: function(data) {
      return data.map(function(s) {
        return { name: s };
      });
    }
  });
});
