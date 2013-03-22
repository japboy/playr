'use strict'

define [
  'jquery'
  'modules/base'
], ($, Base) ->

  ###*
  # @link https://developers.google.com/youtube/iframe_api_reference
  ###
  class Player extends Base.View

    _player: undefined
    _height: 0
    _width: 0
    _options: {}
    _done: false

    videoId: undefined

    update: =>
      # a logic behind cover calculations
      windowHeight = @model.get 'height'
      windowWidth = @model.get 'width'
      windowRatio = windowHeight / windowWidth
      height = 390
      width = 640
      ratio = height / width

      if windowRatio > ratio
        @_height = windowHeight
        @_width = windowHeight / ratio
      else
        @_height = windowWidth / ratio
        @_width = windowWidth

    handlePlayerReady: (ev) =>
      ev.target.playVideo()

    handlePlayerStateChange: (ev) =>
      if YT.PlayerState.ENDED is ev.data
        location.reload()

    handleYouTubeIframeAPIReady: =>
      @update()

      @_options =
        height: @_height
        width: @_width
        videoId: @videoId
        playerVars:
          autoplay: 0
          controls: 0
          rel: 0
          showinfo: 0
        events:
          'onReady': @handlePlayerReady
          'onStateChange': @handlePlayerStateChange

      @_player = new YT.Player @el.id, @_options  # Lose the DOM reference

      @listenTo @model, 'change:width', @render
      @listenTo @model, 'change:height', @render

      @setElement document.getElementById(@el.id)  # Set the reference again
      @render()

    loadApi: =>
      $script = $('<script src="//www.youtube.com/iframe_api"/>')
      $('script').prepend $script

    stop: =>
      @_player.stopVideo()

    render: =>
      @update()

      @$el.attr
        width: @_width
        height: @_height
      .css
        marginLeft: "-#{@_width / 2}px"
        marginTop: "-#{@_height / 2}px"

      return @

    initialize: (options) =>
      @videoId = options.videoId
      window.onYouTubeIframeAPIReady = @handleYouTubeIframeAPIReady
      @loadApi()


  YouTube =
    Player: Player

  return YouTube
