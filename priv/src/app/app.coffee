window.Omak = {
	Models: {}
	Collections: {}
	Controllers: {}
	Views: {}
	init: $ -> 
		t = new Trianglify()
		pattern = t.generate $(window).width(), $(window).height()
		$('#container').hide()
		$('#container').css 'background-image', pattern.dataUrl
		$('#container').fadeIn 2000
}

Omak.init()
