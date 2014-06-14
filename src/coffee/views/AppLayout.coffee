define ["marionette", "templates/appLayout"], (Marionette, tmplAppLayout) ->
	class AppLayout extends Marionette.Layout
		template: tmplAppLayout

		