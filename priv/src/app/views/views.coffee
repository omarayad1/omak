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
    'keyup input.mobile-text': 'validateMobile'
    'keyup input': 'validateAll'
    'click .submit-personal-data': 'personalSubmit'
  personalSubmit: ->
    $.post('/email/insertEmail', {
        'email': @$el.find('.email-text').val()
        'validation_id': @$el.find('.validation-text').val()
        'first_name': @$el.find('.first-name-text').val()
        'last_name': @$el.find('.last-name-text').val()
        'univ_id': @$el.find('.univ-id-text').val()
        'mobile_num': @$el.find('.mobile-text').val()
      },
    (response) ->
      if response.success
        $.UIkit.notify(
          message: 'All is good, no errors'
          status: 'success'
          timeout: 3000
        )
      else if !response.success
        $.UIkit.notify(
          message: response.reason
          status: 'warning'
          timeout: 3000
        )
    )
  validateAll: ->
    if @validateId() and @validateMobile() and @$el.find('.first-name-text').val() and @$el.find('.last-name-text').val()
      @$el.find('.submit-personal-data').removeAttr('disabled')
    else
      @$el.find('.submit-personal-data').attr('disabled', 'disabled')
  validateMobile: ->
    mobileNumber = @$el.find('.mobile-text')
    if mobileNumber.val().length != 11 or !mobileNumber.val().match(/^\d+$/) or mobileNumber.val().indexOf('01') != 0
      mobileNumber.removeClass('uk-form-success')
      mobileNumber.addClass('uk-form-danger')
      false
    else
      mobileNumber.removeClass('uk-form-danger')
      mobileNumber.addClass('uk-form-success')
      true
  validateId: ->
    univId = @$el.find('.univ-id-text')
    if univId.val().indexOf('900') != 0 or univId.val().length != 9 or !univId.val().match(/^\d+$/)
      univId.removeClass('uk-form-success')
      univId.addClass('uk-form-danger')
      false
    else
      univId.addClass('uk-form-success')
      univId.removeClass('uk-form-danger')
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