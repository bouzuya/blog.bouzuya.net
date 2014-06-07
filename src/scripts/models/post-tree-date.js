define(['backbone'], function(Backbone) {
  return Backbone.Model.extend({
    idAttribute: 'date',

    toJSON: function() {
      var json = Backbone.Model.prototype.toJSON.call(this);
      json.post = json.post.toJSON();
      return json;
    }
  });
});
