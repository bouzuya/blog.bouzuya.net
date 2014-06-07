define([
  'backbone',
  'models/post-tree-year',
  'models/post-tree-month',
  'models/post-tree-date'
], function(Backbone, PostTreeYear, PostTreeMonth, PostTreeDate) {
  return Backbone.Collection.extend({
    model: PostTreeYear,

    parse: function(posts) {
      return posts.reduce(function(years, post) {
        var dateString = post.get('date');
        var year = dateString.split('-')[0];
        var month = dateString.split('-')[1];
        var date = dateString.split('-')[2];

        var ys = years.filter(function(item) {
          return item.get('year') === year;
        });
        var y;
        if (ys.length > 0) {
          y = ys[0];
        } else {
          y = new PostTreeYear({ year: year });
          years.push(y);
        }
        var m = y.get('months').add({ month: month });
        m.get('dates').add({ date: date, post: post });
        return years;
      }, []);
    }
  });
});
