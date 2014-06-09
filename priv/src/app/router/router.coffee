Omak.Routes = Backbone.Router.extend(
	routes:
		'': 'home'
		'home': 'home'
		'database': 'database'
		'about': 'about'
		'faq': 'faq'
		'validateEmail/:validationKey': 'validateEmail'
	)

omakRouter = new Omak.Routes()

omakRouter.on 'route:database', ->
	console.log 'you have just seen the database'
omakRouter.on 'route:home', ->
	viewOfHome = new Omak.Views.homeView
	viewOfHome.setElement('#content')
	viewOfHome.render()
omakRouter.on 'route:validateEmail', (validationKey) ->
	$.get('/email/validate/' + validationKey, (data) ->
		console.log(data)
		)
	viewOfValidation = new Omak.Views.validateView
	viewOfValidation.setElement('#content')
	viewOfValidation.render()

Backbone.history.start()