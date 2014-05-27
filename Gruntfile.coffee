module.exports = (grunt) ->
	
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'

	grunt.initConfig(
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			compile:
				files:
					'priv/static/js/coffee-compile.js': ['priv/src/app/*.coffee', 'priv/src/app/views/*.coffee', 'priv/src/app/router/*.coffee']

		uglify:
			options:
				beautify: true
			my_target:
				files:
					'priv/static/js/script.min.js': [
						'priv/src/vendor/jquery.min.js', 
						'priv/src/vendor/d3.min.js', 
						'priv/src/vendor/trianglify.min.js', 
						'priv/src/vendor/underscore.min.js',
						'priv/src/vendor/backbone.min.js',
						'priv/static/js/coffee-compile.js',
						'priv/src/vendor/*.js'
					]
		)

	grunt.registerTask 'default', ['coffee', 'uglify']