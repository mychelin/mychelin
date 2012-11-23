# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  getRestaurants = (latitude, longitude) ->
    $.get '/restaurants.json',
      lat: latitude
      lng: longitude
    , (data) =>
      restaurants_list = $('#restaurants_list')
      if data.length > 0
        @clearMarks()
        restaurants_list.children().slice(2).remove()
        for restaurant in data
          entry = $("<a href='javascript:void(0)' class='panel-stacked-item' onClick=\"alert('#{ restaurant.name }')\">
                       <h4>#{ restaurant.name }</h4>
                       <p>#{ restaurant.address }</p>
                     </div>")
          restaurants_list.append(entry)

          [lat, lng] = restaurant.location.split(',')
          @setMark(lat, lng, restaurant.name)

  #
  # /posts/new
  #
  if $('body.posts.new').length > 0
    map_canvas = $('#map_canvas')
    map_canvas.height(map_canvas.width() * 0.5)

    map = new $.Map('#map_canvas')
    map.markCenter()
    map.watchCurrentPos getRestaurants
