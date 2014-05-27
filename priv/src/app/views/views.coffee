Omak.Views.homeView = Backbone.View.extend(
	el: $('#content')
	tagName: 'div'
	className: 'omak-home'
	render: ->
		compiledTemplate = _.template($('#home').html())
		@$el.html(compiledTemplate)
		@
	)