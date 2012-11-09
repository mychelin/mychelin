# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('body.restaurants.new').ready ($) ->
    map = new $.Map('#map_canvas')
    map.getCurrentPosition (latitude, longitude) ->
      map.setCenter latitude, longitude
      $.get '/service/restaurants',
        latitude: latitude
        longitude: longitude
      , (data) =>
        restaurants_list = $('#restaurants_list')
        if data.status == 'OK'
          for result in data.results
            entry = $('<div>' +
              '<h4>' + result.name + '</h4>' +
              result.vicinity +
            '</div>')
            entry.click () =>
              alert result.reference

            restaurants_list.append(entry)

            l = result.geometry.location
            new google.maps.Marker
              position: new google.maps.LatLng(l.lat, l.lng)
              map: map.map
              title: result.name

  map_canvas = $('body.restaurants #map_canvas')
  map_canvas.ready ->
    map_canvas.height(map_canvas.width())
