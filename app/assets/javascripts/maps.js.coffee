# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  geocoder = new google.maps.Geocoder()

  default_latlng = new google.maps.LatLng 43.66365, -79.377594

  if document.getElementById("global_map") != null
    global_map = new google.maps.Map document.getElementById("global_map"),
      center: default_latlng,
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false

    incidentBounds = new google.maps.LatLngBounds()
    markers = {}

    plotMapCallback = (incidents_json) ->
      console.log incidents_json
      for incident in incidents_json
        vLatLng = new google.maps.LatLng incident.latitude, incident.longitude
        markers[incident.id] = new google.maps.Marker
          map: global_map,
          position: vLatLng,
          title: incident.to_s
        incidentBounds.extend vLatLng

      # global_map.setCenter incidentBounds.getCenter()
      # global_map.fitBounds incidentBounds

    jQuery.get '/incidents.json', plotMapCallback, 'json'


  if document.getElementById("preview_map") != null
    preview_map = new google.maps.Map document.getElementById("preview_map"),
      center: default_latlng,
      zoom: 13,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false,
      mapTypeControl: false,
      scrollwheel: false

    preview_marker = new google.maps.Marker
      map: preview_map,
      position: default_latlng,
      visible: false

    window.geocodeAddressAndRenderPreview = ->
      addr = $('#incident_location').val()
      return if addr.length == 0
      $('#preview_map_updating').fadeIn()
      geocoder.geocode {'address': addr}, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          preview_map.setCenter results[0].geometry.location
          preview_map.setZoom 13
          preview_marker.setPosition results[0].geometry.location
          preview_marker.setVisible true
          $('#incident_latitude').val results[0].geometry.location.lat()
          $('#incident_longitude').val results[0].geometry.location.lng()
        else
          console.log "Geocode was not successful for the following reason: " + status
        $('#preview_map_updating').fadeOut()

    if $('#incident_location').val().length > 0
      saved_latlng = new google.maps.LatLng $('#incident_latitude').val(), $('#incident_longitude').val()
      preview_map.setCenter saved_latlng
      preview_map.setZoom 15
      preview_marker.setPosition saved_latlng
      preview_marker.setVisible true

    $('#incident_location').on 'keyup', $.debounce(500, window.geocodeAddressAndRenderPreview)
