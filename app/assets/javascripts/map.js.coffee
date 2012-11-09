class Map
  constructor: (selector, options) ->
    if not options
      options =
        zoom: 14
        mapTypeId: google.maps.MapTypeId.ROADMAP

    @map = new google.maps.Map($(selector).get(0), options)

    @cmLayer = new google.maps.KmlLayer 'http://dev.mychelin.me/kml/centerMark.kml',
      preserveViewport: true
      map: @map

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

$.Map = Map
