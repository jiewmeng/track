define ["backbone"], (Backbone) ->
	class Expence extends Backbone.Model
		defaults: ->
			name: ""
			category: ""
			price: 0
			date: new Date()