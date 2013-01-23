_ = window?._ or require 'underscore'
Backbone = window?.Backbone or require 'backbone'

_.extend Backbone.Collection::,
  save: (options) ->
    options = if options then _.clone options else {}
    options.parse = true if options.parse is undefined
    success = options.success
    options.success = (__, resp, options) =>
      @reset @parse(resp, options), options
      success? @, resp, options
    @sync 'create', @, options

  destroy: (options) ->
    options = if options then _.clone options else {}
    success = options.success
    options.success = (__, resp, options) =>
      @reset [], options
      success? @, resp, options
    @sync 'delete', @, options
