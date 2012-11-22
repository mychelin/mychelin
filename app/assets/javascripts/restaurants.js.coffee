# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # Helper to load detail restaurant information
  $.load_detail = (reference) ->
    $.get '/service/restaurant/' + reference, (data) ->
      if data.status == 'OK'
        result = data.result
        $('#restaurant_name').val result.name
        loc = [result.geometry.location.lat, result.geometry.location.lng]
        $('#restaurant_location').val (loc.join ',')
        $('#restaurant_tel').val result.formatted_phone_number
        $('#restaurant_address').val result.formatted_address
        $('#restaurant_url').val result.url

        $('#modal_form').modal('show')

  getPlaces = (latitude, longitude) ->
    $.get '/service/restaurants',
      latitude: latitude
      longitude: longitude
    , (data) =>
      restaurants_list = $('#restaurants_list')
      if data.status == 'OK'
        @clearMarks()
        # Remove list element other than title and map
        restaurants_list.children().slice(2).remove()

        for result in data.results
          entry = $("<div class='panel-content' onClick=\"$.load_detail('#{ result.reference }')\">
                       <div class='panel-inner'><h4>#{ result.name }</h4>
                          #{ result.vicinity }
                       </div>
                     </div>")
          restaurants_list.append(entry)

          l = result.geometry.location
          @setMark(l.lat, l.lng, result.name)

  #
  # Common in /restaurants/*
  #
  load_hook = []
  load_hook.push () ->
    map_canvas = $('body.restaurants #map_canvas')
    map_canvas.height(map_canvas.width() * 0.5)

  #
  # /restaurants/new
  #
  if $('body.restaurants.new').length > 0
    hook.call(this) for hook in load_hook

    map = new $.Map('#map_canvas')
    map.markCenter()
    map.watchCurrentPos getPlaces

  #
  # /restaurants/show/:id
  #
  else if $('body.restaurants.show').length > 0
    hook.call(this) for hook in load_hook

    map = new $.Map('#map_canvas')
    [lat, lng] = $('#map_canvas').data('mychelin-location').split(',')
    map.setCenter(lat, lng)
    map.setMark(lat, lng)