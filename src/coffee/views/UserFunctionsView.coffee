define ["marionette", "templates/userFunctions"], (Marionette, tmplUserFunctions) ->
	class UserFunctionsView extends Marionette.ItemView
		template: tmplUserFunctions
