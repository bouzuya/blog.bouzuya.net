define([
  'marionette',
  'hbs!templates/post-tree-month',
  'views/post-tree-dates'
], function(Marionette, template, PostTreeDatesView) {
  return Marionette.Layout.extend({
    className: 'post-tree-month',

    template: template,

    ui: {
      'month': '.month'
    },

    events: {
      'click .month': 'onClick'
    },

    regions: {
      'dates': '.dates-region'
    },

    onClick: function() {
      if (!this.dates.currentView) {
        var view = new PostTreeDatesView({
          collection: this.model.get('dates')
        });
        this.ui.month.addClass('open');
        this.dates.show(view);
      } else {
        this.ui.month.removeClass('open');
        this.dates.reset();
      }
      return false;
    }
  });
});
