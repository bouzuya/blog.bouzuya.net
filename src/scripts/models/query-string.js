define(['backbone'], function(Backbone) {
  return Backbone.Model.extend({}, {
    parse: function(queryString) {
      if (!queryString) {
        return {};
      }
      return queryString.split('&').reduce(function(query, kv) {
        var parsed = kv.split('=');
        var key = parsed[0];
        var value = parsed[1];
        query[key] = value;
        return query;
      }, {});
    }
  });
});
