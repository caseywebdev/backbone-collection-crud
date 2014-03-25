((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['underscore', 'backbone'], factory
  else if exports?
    module.exports = factory require('underscore'), require('backbone')
  else
    factory root._, root.Backbone
) this, (_, Backbone) ->

  # Private method from backbone.js, copied here verbatim.
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
        @[if options.reset then 'reset' : 'set'] models, options
        success? @, resp, options
        @trigger 'sync', model, resp, options
      wrapError @, options
      @sync (if method is 'save' then 'create' else 'delete'), @, options
