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
	$.get '/email/validate/' + validationKey, (data) ->
    if data.value.length > 0
      console.log(data)
      viewOfValidation = new Omak.Views.validateView
      viewOfValidation.setElement('#content')
      viewOfValidation.render()
    else
      console.log("batee5")

Backbone.history.start()