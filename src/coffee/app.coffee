require [
		"dropbox"
		"jquery"
		"initMarionette"
		"TrackApp"
		"views/UserFunctionsView"
		"views/LandingPageView"
		"bootstrap"
	], (
		Dropbox
		$
		initMarionette
		TrackApp
		UserFunctionsView
		LandingPageView
	) ->

	initMarionette()

	trackApp = TrackApp.getInstance()

	trackApp.addRegions
		userFunctionsRegion: "#userFunctions",
		contentRegion: "#content"
	trackApp.userFunctionsRegion.show(new UserFunctionsView())
	trackApp.contentRegion.show(new LandingPageView())

	dropboxClient = new Dropbox.Client
		key: "qzg57uoll1mt4p4"
	dropboxClient.authenticate {
		interactive: false
	}, (err) ->
		if err
			console.log "An error has occured: ", err

	$(".btn-login-dropbox").on "click", ->
		dropboxClient.authenticate()
	