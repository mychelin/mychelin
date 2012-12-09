# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  Posts = 
    show_form: (restaurant) ->
      $('#modal_form #restaurant_name').text restaurant.name
      $('#modal_form #post_restaurant_id').val restaurant.id
      $('#modal_form').modal('show')

    getRestaurants: (latitude, longitude) ->
      $.get '/restaurants.json',
        lat: latitude
        lng: longitude
      , (data) =>
        restaurants_list = $('#restaurants_list')
        if data.length > 0
          @clearMarks()
          restaurants_list.children().slice(2).remove()
          clickHandler = -> Posts.show_form $(this).data('restaurant')
          for restaurant in data
            entry = $("<a href='javascript:void(0)'
                          class='panel-stacked-item'>
                         <h4>#{ restaurant.name }</h4>
                         <p>#{ restaurant.address }</p>
                       </a>")
            restaurants_list.append(entry)
            entry.click clickHandler
            entry.data 'restaurant',
              name : restaurant.name
              id   : restaurant.id
   
            [lat, lng] = restaurant.location.split(',')
            @setMark(lat, lng, restaurant.name)

  #
  # /posts/new
  #
  if $('body.posts.new').length > 0
    # display modal window when accessed with '/posts/new?restaurant_id=1
    if restaurant = $('#modal_form').data('restaurant')
      Posts.show_form(restaurant)
    else
      map_canvas = $('#map_canvas')
      map_canvas.height(map_canvas.width() * 0.5)
   
      map = new $.Map('#map_canvas')
      map.markCenter()
      map.watchCurrentPos Posts.getRestaurants

