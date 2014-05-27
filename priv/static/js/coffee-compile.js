(function() {
  window.Omak = {
    Models: {},
    Collections: {},
    Controllers: {},
    Views: {},
    Routes: {},
    init: $(function() {
      var pattern, t;
      t = new Trianglify();
      pattern = t.generate($(window).width(), $(window).height());
      $('#container').hide();
      $('#container').css('background-image', pattern.dataUrl);
      return $('#container').fadeIn(3000);
    })
  };

  Omak.init;

}).call(this);

(function() {
  Omak.Views.homeView = Backbone.View.extend({
    el: $('#content'),
    tagName: 'div',
    className: 'omak-home',
    render: function() {
      var compiledTemplate;
      compiledTemplate = _.template($('#home').html());
      this.$el.html(compiledTemplate);
      return this;
    }
  });

}).call(this);

(function() {
  var omakRouter;

  Omak.Routes = Backbone.Router.extend({
    routes: {
      '': 'home',
      'home': 'home',
      'database': 'database',
      'about': 'about',
      'faq': 'faq'
    }
  });

  omakRouter = new Omak.Routes();

  omakRouter.on('route:database', function() {
    return console.log('you have just seen the database');
  });

  omakRouter.on('route:home', function() {
    var viewOfHome;
    console.log('batee5');
    viewOfHome = new Omak.Views.homeView;
    viewOfHome.setElement('#content');
    return viewOfHome.render();
  });

  Backbone.history.start();

}).call(this);
