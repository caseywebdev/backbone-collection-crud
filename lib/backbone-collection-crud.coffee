_ = window?._ or require 'underscore'
Backbone = window?.Backbone or require 'backbone'

wrapError = (model, options) ->
  error = options.error
  options.error = (resp) ->
    error? model, resp, options
    model.trigger 'error', model, resp, options

_.each ['save', 'destroy'], (method) ->
  Backbone.Collection::[method] = (options) ->
    options = if options then _.clone options else {}
    options.parse = true if options.parse is undefined
    success = options.success
    options.success = (resp) =>
      models = if method is 'save' then resp else []
      @[if options.update then 'update' : 'reset'] models, options
      success? @, resp, options
      @trigger 'sync', model, resp, options
    wrapError @, options
    @sync if method is 'save' then 'create' else 'delete', @, options
