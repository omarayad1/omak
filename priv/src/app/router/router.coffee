Omak.Routes = Backbone.Router.extend(
	routes:
		'': 'home'
		'home': 'home'
		'database': 'database'
		'about': 'about'
		'faq': 'faq'
	)

omakRouter = new Omak.Routes()

omakRouter.on 'route:database', ->
	console.log 'you have just seen the database'
omakRouter.on 'route:home', ->
	viewOfHome = new Omak.Views.homeView
	viewOfHome.setElement('#content')
	viewOfHome.render()

Backbone.history.start()