# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('body.restaurants.new').ready ($) ->
    map = new $.Map()
    map.display()

  map_canvas = $('body.restaurants #map_canvas')
  map_canvas.ready ->
    map_canvas.height(map_canvas.width())
