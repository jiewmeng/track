module.exports = (grunt) ->
	grunt.initConfig({
		copy:
			# copy all assets into /dist
			assets:
				files: [{
					expand: true
					cwd: "src/assets"
					src: "**"
					dest: "dist"
				}]
			# copy all library (bower_components) files into respective dist folders 
			vendor:
				files:
					"dist/vendor/js/require.js": "bower_components/requirejs/require.js"
					"dist/vendor/js/underscore.js": "bower_components/underscore/underscore.js"
					"dist/vendor/js/jquery.js": "bower_components/jquery2/jquery.js"
					"dist/vendor/js/backbone.js": "bower_components/backbone/backbone.js"
					"dist/vendor/js/backbone.marionette.js": "bower_components/marionette/backbone.marionette.js"

		coffee:
			# compile CoffeeScript into dist (multiple files)
			compile:
				options:
					bare: true # since requireJS is used
					join: false # r.js used to do this
				files: [{
					expand: true
					flatten: true
					cwd: "src/coffee"
					src: ["**/*.coffee"]
					dest: "dist/js"
					ext: ".js"
				}]
			
		stylus:
			# compile Stylus into dist/css/app.css
			compile:
				options:
					compress: false
					linenos: true
				files:
					"dist/css/app.css": ["src/stylus/app.styl"]
		jade:
			# compile Jade into dist
			compile:
				options:
					pretty: true
				files: [{
					expand:	true
					cwd: "src/jade"
					src: ["*.jade"]
					dest: "dist"
					ext: ".html"
				}]

		watch:
			options:
				spawn: false
				livereload: true
			# watch and compile CoffeeScript
			coffee:
				files: "src/coffee/**/*.coffee"
				tasks: ["coffee", "requirejs"]
			# watch and compile Stylus files
			stylus:
				files: "src/stylus/**/*.styl"
				tasks: ["stylus"]
			# watch and compile Jade files
			jade:
				files: "src/jade/**/*.jade"
				tasks: ["jade"]
			# watch and copy assets
			assets:
				files: "src/assets/**"
				tasks: ["copy:assets"]
			# watch and copy bower components
			bower_components:
				files: "bower_components"
				tasks: ["copy:vendor"]

		connect:
			server:
				options:
					livereload: true
					base: "dist"

		requirejs:
			concat:
				options:
					baseUrl: "dist/js"
					name: "app"
					out: "dist/js/app-all.js"

	})

	grunt.loadNpmTasks('grunt-contrib-copy')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-stylus')
	grunt.loadNpmTasks('grunt-contrib-jade')
	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.loadNpmTasks('grunt-contrib-connect')
	grunt.loadNpmTasks('grunt-contrib-requirejs')

	# the task you run for development
	grunt.registerTask("build", ["copy", "coffee", "stylus", "jade"])
	grunt.registerTask("server", ["build", "connect", "watch"])