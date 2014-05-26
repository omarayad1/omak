main_view = Backbone.View.extend(
	el: $('body')
	render: ->
		t = new Trianglify
		pattern = t.generate(document.body.clientWidth, document.body.clientHeight)
		@$el.css 'background-image', pattern.dataUrl
	)
app = new main_view