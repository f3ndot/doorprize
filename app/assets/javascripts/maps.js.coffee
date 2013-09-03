# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  geocoder = new google.maps.Geocoder()

  default_latlng = new google.maps.LatLng 43.66365, -79.377594

  $('.incident_list_location_map').each ->
    $incident_map_div = $(this)
    incident_coords = new google.maps.LatLng $incident_map_div.data('latitude'), $incident_map_div.data('longitude')
    incident_map = new google.maps.Map this,
      center: incident_coords,
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false,
      streetViewControl: false,
      rotateControl: false,
      scaleControl: false,
      overviewMapControl: false,
      mapTypeControl: false,
    incident_marker = new google.maps.Marker
      map: incident_map,
      position: incident_coords,
      visible: true
    google.maps.event.addListener incident_marker, 'click', ->
      window.location.href = $incident_map_div.data('url')

  if document.getElementById("global_map") != null
    global_map = new google.maps.Map document.getElementById("global_map"),
      center: default_latlng,
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false

    incidentBounds = new google.maps.LatLngBounds()
    markers = {}

    plotMapCallback = (incidents_json) ->
      for incident in incidents_json
        do (incident) ->
          vLatLng = new google.maps.LatLng incident.latitude, incident.longitude
          markers[incident.id] = new google.maps.Marker
            map: global_map,
            position: vLatLng,
            title: incident.to_s
          incidentBounds.extend vLatLng
          google.maps.event.addListener markers[incident.id], 'click', ->
            window.location.href = incident.url

      global_map.setCenter incidentBounds.getCenter()
      global_map.fitBounds incidentBounds

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
      visible: false,
      animation: google.maps.Animation.DROP


    google.maps.event.addListener preview_map, 'click', (event) ->
      preview_marker.setPosition event.latLng
      preview_marker.setVisible true
      $('#incident_latitude').val event.latLng.lat()
      $('#incident_longitude').val event.latLng.lng()
      $('#incident_location').val event.latLng.toString()

    window.geocodeAddressAndRenderPreview = ->
      addr = $('#incident_location').val()
      return if addr.length == 0
      $('#preview_map_updating').fadeIn()
      geocoder.geocode {'address': addr}, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          preview_map.setCenter results[0].geometry.location
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

  if document.getElementById("incident_map") != null
    incident_map = new google.maps.Map document.getElementById("incident_map"),
      center: default_latlng,
      zoom: 13,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false,
      mapTypeControl: false,
      scrollwheel: false

    incident_marker = new google.maps.Marker
      map: incident_map,
      position: default_latlng,
      visible: false

    saved_latlng = new google.maps.LatLng $('#incident_map').data('latitude'), $('#incident_map').data('longitude')
    incident_map.setCenter saved_latlng
    incident_map.setZoom 15
    incident_marker.setPosition saved_latlng
    incident_marker.setVisible true
