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
    events: {
      'click button.submit-email': 'submitEmail',
      'keyup input.email-text': 'validateEmail'
    },
    submitEmail: function() {
      var aucEmail;
      aucEmail = this.$el.find('.email-text').val();
      return $.post('/email/submit', {
        'email': aucEmail
      }, function(response) {
        if (response.success) {
          return $.UIkit.notify({
            message: 'Great! We sent you an email to validate your email',
            status: 'success',
            timout: 3000
          });
        } else if (!response.success) {
          return $.UIkit.notify({
            message: 'We sense you trying to play our systems',
            status: 'warning',
            timout: 3000
          });
        }
      });
    },
    validateEmail: function() {
      var enteredEmail;
      enteredEmail = this.$el.find('.email-text').val();
      if (enteredEmail.indexOf('@aucegypt.edu') > 0) {
        this.$el.find('.submit-email').removeAttr('disabled');
        return this.$el.find('#email-valid-notify').html('<div class="uk-alert uk-alert-success" data-uk-alert><a href="" class="uk-alert-close uk-close"></a><p>Your Email is a Valid @AUC mail you may now submit</p></div>');
      } else {
        this.$el.find('.submit-email').attr('disabled', 'disabled');
        return this.$el.find('#email-valid-notify').html('<div class="uk-alert uk-alert-danger" data-uk-alert><a href="" class="uk-alert-close uk-close"></a><p>Your Email is not a Valid @AUC mail</p></div>');
      }
    },
    render: function() {
      var compiledTemplate;
      compiledTemplate = _.template($('#home').html());
      this.$el.html(compiledTemplate);
      return this;
    }
  });

  Omak.Views.validateView = Backbone.View.extend({
    el: $('#content'),
    tagName: 'div',
    className: 'omak-validate',
    events: {
      'click button.submit-validation': 'submitValidation'
    },
    render: function() {
      var compiledTemplate;
      compiledTemplate = _.template($('#validation').html());
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
      'faq': 'faq',
      'validateEmail/:validationKey': 'validateEmail'
    }
  });

  omakRouter = new Omak.Routes();

  omakRouter.on('route:database', function() {
    return console.log('you have just seen the database');
  });

  omakRouter.on('route:home', function() {
    var viewOfHome;
    viewOfHome = new Omak.Views.homeView;
    viewOfHome.setElement('#content');
    return viewOfHome.render();
  });

  omakRouter.on('route:validateEmail', function(validationKey) {
    return $.get('/email/validate/' + validationKey, function(data) {
      var goodData, viewOfValidation;
      goodData = data;
      console.log(goodData.value);
      if (goodData.value.length > 0) {
        console.log(goodData);
        viewOfValidation = new Omak.Views.validateView;
        viewOfValidation.setElement('#content');
        return viewOfValidation.render();
      } else {
        return console.log("batee5");
      }
    });
  });

  Backbone.history.start();

}).call(this);
