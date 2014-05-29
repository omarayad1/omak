Omak.Views.homeView = Backbone.View.extend(
	el: $('#content')
	tagName: 'div'
	className: 'omak-home'
	events:
		'click button.submit-email': 'submitEmail'
	submitEmail: ->
		aucEmail = @$el.find('.email-text').val()
		$.post('/submit/email', {'email': aucEmail}, (response) ->
			console.log(response)
			)
	render: ->
		compiledTemplate = _.template($('#home').html())
		@$el.html(compiledTemplate)
		@
	)