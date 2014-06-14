define ["marionette", "templates/landingPage"], (Marionette, tmplLandingPage) ->
	class LandingPageView extends Marionette.ItemView
		template: tmplLandingPage