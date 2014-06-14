Omak.Views.homeView = Backbone.View.extend(
  el: $('#content')
  template: _.template($('#home').html())
  tagName: 'div'
  className: 'omak-home'
  events:
    'click button.submit-email': 'submitEmail'
    'keyup input.email-text': 'validateEmail'
  submitEmail: ->
    aucEmail = @$el.find('.email-text').val()
    $.post('/email/submit', {'email': aucEmail}, (response) ->
      if response.success
        $.UIkit.notify(
          message: 'Great! We sent you an email to validate your email'
          status: 'success'
          timeout: 3000
          )
      else if !response.success
        $.UIkit.notify(
          message: 'We sense you trying to play our systems'
          status: 'warning'
          timeout: 3000
          )
      )
  validateEmail: ->
    enteredEmail = @$el.find('.email-text').val()
    if enteredEmail.indexOf('@aucegypt.edu') > 0
      @$el.find('.submit-email').removeAttr('disabled')
      @$el.find('#email-valid-notify').html('<div class="uk-alert uk-alert-success" data-uk-alert><a href="" class="uk-alert-close uk-close"></a><p>Your Email is a Valid @AUC mail you may now submit</p></div>')
    else
      @$el.find('.submit-email').attr('disabled', 'disabled')
      @$el.find('#email-valid-notify').html('<div class="uk-alert uk-alert-danger" data-uk-alert><a href="" class="uk-alert-close uk-close"></a><p>Your Email is not a Valid @AUC mail</p></div>')
  render: ->
    @$el.html(@template)
    @
  )

Omak.Views.validateView = Backbone.View.extend(
  el: $('#content')
  template: _.template($('#validation').html())
  tagName: 'div'
  className: 'omak-validate'
  events:
    'keyup input.univ-id-text': 'validateId'
    # 'click .submit-personal-data': 'personalSubmit'
  validateId: ->
    if @$el.find('.univ-id-text').val().indexOf('900') != 0 or @$el.find('.univ-id-text').val().length != 9
      @$el.find('.univ-id-text').removeClass('uk-form-success')
      @$el.find('.univ-id-text').addClass('uk-form-danger')
      false
    else
      @$el.find('.univ-id-text').addClass('uk-form-success')
      @$el.find('.univ-id-text').removeClass('uk-form-danger')
      true
  render: ->
    userData = @model
    compiledTemplate = @template(userData)
    @$el.html(compiledTemplate)
    @
  )

Omak.Views.validateErrorView = Backbone.View.extend(
  el: $('#content')
  template: _.template($('#validation-error').html())
  tagName: 'div'
  className: 'omak-validate-error'
  render: ->
    @$el.html(@template)
    @
)