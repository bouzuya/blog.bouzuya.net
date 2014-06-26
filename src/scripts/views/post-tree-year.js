define([
  'marionette',
  'hbs!templates/post-tree-year',
  'collections/post-tree-months',
  'views/post-tree-months'
], function(Marionette, template, PostTreeMonths, PostTreeMonthsView) {
  return Marionette.Layout.extend({
    className: 'post-tree-year',

    template: template,

    ui: {
      'year': '.year'
    },

    events: {
      'click .year': 'onClick'
    },

    regions: {
      'months': '.months-region'
    },

    templateHelpers: function() {
      var postCount = this.model.get('months').reduce(function(count, month) {
        return count + month.get('dates').length;
      }, 0);
      return { postCount: function() { return postCount; } };
    },

    onClick: function() {
      if (!this.months.currentView) {
        var view = new PostTreeMonthsView({
          collection: this.model.get('months')
        });
        this.ui.year.addClass('open');
        this.months.show(view);
      } else {
        this.ui.year.removeClass('open');
        this.months.reset();
      }
      return false;
    }
  });
});
