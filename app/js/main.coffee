'use strict'

require [
  'jquery'
  'modules/youtube'
  'modules/window'
], ($, YouTube, Window) ->

  videoIds = [
    'j5WxRC9jcxs'
    'yTpmyhavYCM'
    'O7IZSi7nlPc'
    'KB5pmGZenRo'
    'uDvPgXeK998'
    'AIOQ4NXt4c8'
  ]

  videoId = videoIds[Math.floor(Math.random() * videoIds.length)]

  $ ->
    window = Window.window
    player = new YouTube.Player {
      el: '#player'
      model: window
      videoId: videoId
    }

  #$(window).on 'load', handleLoad
  # It's importtant to use $(window).load() instead of $(document).ready!
  # Otherwise Chrome logs tons of damn errors
