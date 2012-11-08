class Map
  constructor: ->
    options =
      zoom: 14
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new google.maps.Map(document.getElementById("map_canvas"), options)

  display: ->
    map = @map
    handleNoGeolocation = @handleNoGelocation

    # Try W3C Geolocation (Preferred)
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition((position) ->
        initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
        map.setCenter(initialLocation);
      , () ->
        handleNoGeolocation(true))

    # Try Google Gears Geolocation
    else if google.gears
      geo = google.gears.factory.create('beta.geolocation');

      geo.getCurrentPosition((position) ->
        initialLocation = new google.maps.LatLng(position.latitude,position.longitude)
        map.setCenter(initialLocation)
      , () ->
        handleNoGeoLocation(true))

    # Browser doesn't support Geolocation
    else
      handleNoGeolocation(false)

  handleNoGeolocation: (errorFlag) ->
    initialLocation = new google.maps.LatLng(35.0061,135.76095) # kyoto
    @map.setCenter(initialLocation)

$.Map = Map