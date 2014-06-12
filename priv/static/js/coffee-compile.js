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
    template: _.template($('#validation').html()),
    model: {
      email: 'default@batee5.com',
      validation_id: 'allYourBaseBelongToUs'
    },
    tagName: 'div',
    className: 'omak-validate',
    events: {
      'keyup input': 'validateInput',
      'click submit-personal-data': 'personalSubmit'
    },
    render: function() {
      var compiledTemplate, userData;
      userData = this.model;
      compiledTemplate = this.template(userData);
      this.$el.html(compiledTemplate);
      return this;
    }
  });

  Omak.Views.validateErrorView = Backbone.View.extend({
    el: $('#content'),
    template: _.template($('#validation-error').html()),
    tagName: 'div',
    className: 'omak-validate-error',
    render: function() {
      this.$el.html(this.template);
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
      var viewOfValidation;
      if (data.value.length > 0) {
        viewOfValidation = new Omak.Views.validateView({
          model: data.value[0]
        });
        return viewOfValidation.render();
      } else {
        viewOfValidation = new Omak.Views.validateErrorView;
        return viewOfValidation.render();
      }
    });
  });

  Backbone.history.start();

}).call(this);
