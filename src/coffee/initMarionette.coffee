# since jade templates will be precompiled on server side for
# client side AMD use, it will just be passed through marionette
# without any special processing. **Usage:** just require this
# function and call it.
#
#     define ["initMarionette"], (initMarionette) ->
#         initMarionette()

define ["marionette"], (Marionette) ->
	return () ->
		Marionette.TemplateCache::loadTemplate = (template) ->
			return template

		Marionette.TemplateCache::compileTemplate = (template) ->
			return template
