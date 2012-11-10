# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
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

  getPlaces = (map, latitude, longitude) ->
    $.get '/service/restaurants',
      latitude: latitude
      longitude: longitude
    , (data) =>
      restaurants_list = $('#restaurants_list')
      if data.status == 'OK'
        restaurants_list.empty()
        for result in data.results
          entry = $("<li onClick=\"$.load_detail('#{ result.reference }')\">
                       <a><h4>#{ result.name }</h4>
                          #{ result.vicinity }
                       </a>
                     </li>")
          restaurants_list.append(entry)

          l = result.geometry.location
          new google.maps.Marker
            position: new google.maps.LatLng(l.lat, l.lng)
            map: map.map
            title: result.name

  $('body.restaurants.new').ready ($) =>
    map = new $.Map('#map_canvas')

    # Initialize center and get restaurants
    map.getCurrentPosition (latitude, longitude) ->
      map.setCenter latitude, longitude
      getPlaces map, latitude, longitude

    # Only get restaurants
    google.maps.event.addListener map.map, 'dragend', () =>
      l = map.map.getCenter()
      getPlaces map, l.lat(), l.lng()

  map_canvas = $('body.restaurants #map_canvas')
  map_canvas.ready ->
    map_canvas.height(map_canvas.width() * 0.5)
