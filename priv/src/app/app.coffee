window.Omak =
	Models: {}
	Collections: {}
	Controllers: {}
	Views: {}
	Routes: {}
	init: $ -> 
		t = new Trianglify()
		pattern = t.generate $(window).width(), $(window).height()
		$('#container').hide()
		$('#container').css 'background-image', pattern.dataUrl
		$('#container').fadeIn 3000

Omak.init
