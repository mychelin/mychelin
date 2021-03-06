class Map
  constructor: (selector, options) ->
    if not options
      options =
        zoom: 15
        mapTypeId: google.maps.MapTypeId.ROADMAP

    @map = new google.maps.Map($(selector).get(0), options)
    @marks = []


  markCenter: ->
    @cmLayer = new google.maps.KmlLayer 'http://dev.mychelin.me/kml/centerMark.kml',
      preserveViewport: true
      map: @map

  setMark: (latitude, longitude, title) ->
    @marks.push (new google.maps.Marker
      position: new google.maps.LatLng(latitude, longitude)
      map: @map
      title: title)

  clearMarks: ->
    mark.setMap(null) for mark in @marks
    @marks.length = 0

  display: ->
    @getCurrentPosition (latitude, longitude) =>
      @setCenter latitude, longitude
    , () =>
      @setCenter 35.0061, 135.76095

  setCenter: (latitude, longitude) ->
    location = new google.maps.LatLng(latitude, longitude)
    @map.setCenter location

  getCurrentPosition: (callback, error_handler) ->
    if not error_handler
      error_handler = () -> false

    # Try W3C Geolocation (Preferred)
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition((position) ->
        callback position.coords.latitude, position.coords.longitude
      , () ->
        error_handler())

    # Try Google Gears Geolocation
    else if google.gears
      geo = google.gears.factory.create('beta.geolocation');

      geo.getCurrentPosition((position) ->
        callback position.latitude, position.longitude
      , () ->
        error_handler())

    # Browser doesn't support Geolocation
    else
      error_handler()

  #
  # watchCurrentPos(callback)
  #
  # This method get current position, and set center of map to that position.
  # Then call `callback` with the current position.
  # And when center of the map is moved, `callback` is called with new center.
  # In the callback function, `this` object is the map itself.
  #
  # Example:
  #   watchCurrentPos (latitude, longitude) =>
  #     this.setMark latitude, longitude, 'sample'
  #
  watchCurrentPos: (callback) ->
    # Initialize center and get restaurants
    @getCurrentPosition (latitude, longitude) =>
      @setCenter latitude, longitude
      callback.call _this, latitude, longitude

    # Only get restaurants
    google.maps.event.addListener @map, 'dragend', () =>
      l = @map.getCenter()
      callback.call _this, l.lat(), l.lng()

$.Map = Map
