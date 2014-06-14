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
			libs:
				files:
					"dist/js/libs/require.js": "bower_components/requirejs/require.js"
					"dist/js/libs/underscore.js": "bower_components/underscore/underscore.js"
					"dist/js/libs/jquery.js": "bower_components/jquery2/jquery.js"
					"dist/js/libs/backbone.js": "bower_components/backbone/backbone.js"
					"dist/js/libs/backbone.babysitter.js": "bower_components/backbone.babysitter/lib/backbone.babysitter.js"
					"dist/js/libs/backbone.wreqr.js": "bower_components/backbone.wreqr/lib/backbone.wreqr.js"
					"dist/js/libs/marionette.js": "bower_components/marionette/lib/core/amd/backbone.marionette.js"
					"dist/css/libs/bootstrap.css": "bower_components/bootstrap/dist/css/bootstrap.css"
					"dist/css/libs/bootstrap.theme.css": "bower_components/bootstrap/dist/css/bootstrap.theme.css"
					"dist/fonts/glyphicons-halflings-regular.eot": "bower_components/bootstrap/dist/fonts/glyphicons-halflings-regular.eot"
					"dist/fonts/glyphicons-halflings-regular.svg": "bower_components/bootstrap/dist/fonts/glyphicons-halflings-regular.svg"
					"dist/fonts/glyphicons-halflings-regular.ttf": "bower_components/bootstrap/dist/fonts/glyphicons-halflings-regular.ttf"
					"dist/fonts/glyphicons-halflings-regular.woff": "bower_components/bootstrap/dist/fonts/glyphicons-halflings-regular.woff"
					"dist/js/libs/bootstrap.js": "bower_components/bootstrap/dist/js/bootstrap.js"
					"dist/fonts/FontAwesome.otf": "bower_components/fontawesome/fonts/FontAwesome.otf"
					"dist/fonts/fontawesome-webfont.eot": "bower_components/fontawesome/fonts/fontawesome-webfont.eot"
					"dist/fonts/fontawesome-webfont.svg": "bower_components/fontawesome/fonts/fontawesome-webfont.svg"
					"dist/fonts/fontawesome-webfont.ttf": "bower_components/fontawesome/fonts/fontawesome-webfont.ttf"
					"dist/fonts/fontawesome-webfont.woff": "bower_components/fontawesome/fonts/fontawesome-webfont.woff"
					"dist/css/libs/font-awesome.css": "bower_components/fontawesome/css/font-awesome.css"
					"dist/js/libs/runtime.js": "bower_components/jade/runtime.js"


		coffee:
			# compile CoffeeScript into dist (multiple files)
			compile:
				options:
					bare: true # since requireJS is used
					join: false # r.js used to do this
				files: [{
					expand: true
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
			# pre-compile client templates (for use with AMD)
			clientTemplates:
				options:
					client: true
					amd: true
					namespace: false
				files: [{
					expand: true
					cwd: "src/jade/templates"
					src: ["**/*.jade"]
					dest: "dist/templates"
					ext: ".js"
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
				tasks: ["stylus", "concat:css"]
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
				tasks: ["copy:libs"]

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
					optimize: "none"
					shim:
						jquery:
							exports: "jQuery"
						bootstrap:
							deps: ["jquery"]
						underscore:
							exports: "_"
						backbone:
							deps: [
								"underscore",
								"jquery"
							]
							exports: "Backbone"
						marionette:
							deps: [
								"backbone",
								"backbone.babysitter",
								"backbone.wreqr"
							]
							exports: "Marionette"
						dropbox: 
							exports: "Dropbox"
					paths:
						jquery: "libs/jquery"
						bootstrap: "libs/bootstrap"
						underscore: "libs/underscore"
						backbone: "libs/backbone"
						"backbone.babysitter": "libs/backbone.babysitter"
						"backbone.wreqr": "libs/backbone.wreqr"
						marionette: "libs/marionette"
						dropbox: "libs/dropbox-datastores-1.0.1"
						templates: "../templates"
						jade: "libs/runtime"
		imagemin:
			images:
				files: [{
					expand: true
					cwd: "src/assets/img"
					src: ["**/*.{jpg,jpeg,png,gif}"]
					dest: "src/assets/img"
				}]

		clean:
			dist:
				src: ["dist"]

		concat:
			css:
				src: [
					"dist/css/libs/bootstrap.css"
					"dist/css/libs/bootstrap-theme.css"
					"dist/css/libs/font-awesome.css"
					"dist/css/app.css"
				]
				dest: "dist/css/app-all.css"

	})

	grunt.loadNpmTasks('grunt-contrib-copy')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-stylus')
	grunt.loadNpmTasks('grunt-contrib-jade')
	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.loadNpmTasks('grunt-contrib-connect')
	grunt.loadNpmTasks('grunt-contrib-requirejs')
	grunt.loadNpmTasks('grunt-contrib-imagemin')
	grunt.loadNpmTasks('grunt-contrib-clean')
	grunt.loadNpmTasks('grunt-contrib-concat')

	# the task you run for development
	grunt.registerTask("build", ["copy", "coffee", "stylus", "jade", "concat", "requirejs", "imagemin"])
	grunt.registerTask("server", ["clean", "build", "connect", "watch"])