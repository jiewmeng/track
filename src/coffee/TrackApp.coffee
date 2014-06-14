define ["marionette"], (Marionette) ->

	class TrackApp extends Marionette.Application

	class SingletonTrackApp
		instance = null

		@getInstance: =>
			console.log instance
			return instance ?= new TrackApp()

	return SingletonTrackApp