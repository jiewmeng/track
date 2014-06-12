require ["dropbox", "jquery"], (Dropbox, $) ->
	dropboxClient = new Dropbox.Client
		key: "qzg57uoll1mt4p4"
	dropboxClient.authenticate {
		interactive: false
	}, (err) ->
		if err
			console.log "An error has occured: ", err

	$(".btn-login-dropbox").on "click", ->
		dropboxClient.authenticate()

	