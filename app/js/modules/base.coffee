'use strict'

define [
  'jquery'
  'lodash'
  'backbone'
], ($, _, Backbone) ->

  class Model extends Backbone.Model

    fetch: (options) =>
      options = {} unless options?
      options.crossDomain = true
      options.dataType = 'jsonp'
      options.jsonp = 'jsonp'
      super options


  class Collection extends Backbone.Collection

    request: =>
      console.debug 'Server request started.'

    error: =>
      console.debug 'Server request failed.'

    initialize: =>
      @on 'request', @request
      @on 'error', @error

    fetch: (options) =>
      options = {} unless options?
      options.crossDomain = true
      options.dataType = 'jsonp'
      options.jsonp = 'jsonp'
      super options


  class View extends Backbone.View


  Base =
    Model: Model
    Collection: Collection
    View: View

  return Base
