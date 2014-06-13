define ["marionette", "templates/test"], (Marionette, tmplTest) ->
	class AppLayout extends Marionette.Layout
		template: tmplTest

		