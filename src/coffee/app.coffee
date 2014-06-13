require ["dropbox", "jquery", "initMarionette", "views/AppLayout"], (Dropbox, $, initMarionette, AppLayout) ->

	initMarionette()

	dropboxClient = new Dropbox.Client
		key: "qzg57uoll1mt4p4"
	dropboxClient.authenticate {
		interactive: false
	}, (err) ->
		if err
			console.log "An error has occured: ", err

	$(".btn-login-dropbox").on "click", ->
		dropboxClient.authenticate()

	layout = new AppLayout()
	layout.render()
	console.log(layout.el)

	