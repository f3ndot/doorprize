# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("input#incident_severity").on 'change', (e) ->
    severity_level = parseInt $(this).val(), 10
    severity = $('.severity-levels .severity[data-level=' + severity_level + ']')

    severity_text = severity.text()
    severity_color = severity.data 'color'

    $('.incident_severity .help-block').text severity_text
    $('.incident_severity .help-block').css 'color', severity_color

    if severity_level is 10
      $('.incident_severity .help-block').css 'font-weight', 'bold'
    else
      $('.incident_severity .help-block').css 'font-weight', 'normal'

  if $('.geolocate').size() > 0
    $geocodeModal = $('#geocodeModal')

    geocoder = new google.maps.Geocoder()

    default_latlng = new google.maps.LatLng 43.66365, -79.377594

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

    geocodeAddressAndRender = ->
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
      saved_latlng = new google.maps.LatLng $('#violation_latitude').val(), $('#violation_longitude').val()
      preview_map.setCenter saved_latlng
      preview_map.setZoom 15
      preview_marker.setPosition saved_latlng
      preview_marker.setVisible true

    $('#incident_location').on 'keyup', $.debounce(500, geocodeAddressAndRender)

    $('#geocodeModal').on 'click', '.geocoded-address-choice', (e) ->
      $locationInput = $('#incident_location')
      $locationInput.val $(this).text()
      geocodeAddressAndRender()
      $geocodeModal.modal 'hide'

    $('.get-location').on 'click', (e) ->
      $getLocationBtn = $(this)
      if $getLocationBtn.data('populated') == true
        $geocodeModal.modal 'show'
        return
      $getLocationBtn.addClass 'btn-info'
      $getLocationBtn.find('.gps-text').text ' Locating...'
      gl = navigator.geolocation
      if gl
        gl.getCurrentPosition (
          (position) =>
            $getLocationBtn.removeClass 'btn-danger'
            $getLocationBtn.removeClass 'btn-info'
            $getLocationBtn.addClass 'btn-success'
            $getLocationBtn.find('.gps-text').text ' Located'

            geocodeCallback = (response) ->
              if response.status == 'ZERO_RESULTS'
                $getLocationBtn.removeClass 'btn-info'
                $getLocationBtn.removeClass 'btn-success'
                $getLocationBtn.addClass 'btn-danger'
                $getLocationBtn.find('.gps-text').text ' Couldn\'t get address'
              $geocodeModal.find('.address-list').html ''
              $geocodeModal.find('.address-count').text response.results.length
              for result in response.results
                cleanText = $('<div/>').text(result.formatted_address).html()
                $geocodeModal.find('.address-list').append '<button class="btn btn-block geocoded-address-choice">'+cleanText+'</button>'
              $geocodeModal.modal 'show'
              $getLocationBtn.data 'populated', true

            jQuery.get 'http://maps.googleapis.com/maps/api/geocode/json', { sensor: true, latlng: position.coords.latitude+','+position.coords.longitude }, geocodeCallback, 'json'
        ),(
          (error) =>
            $getLocationBtn.removeClass 'btn-info'
            $getLocationBtn.removeClass 'btn-success'
            switch error.code
              when error.PERMISSION_DENIED
                $getLocationBtn.addClass 'btn-danger'
                $getLocationBtn.find('.gps-text').text ' You denied permission'
              when error.POSITION_UNAVAILABLE
                $getLocationBtn.addClass 'btn-danger'
                $getLocationBtn.find('.gps-text').text ' Position unavailable'
              when error.TIMEOUT
                $getLocationBtn.addClass 'btn-danger'
                $getLocationBtn.find('.gps-text').text ' Timed out'
              when error.UNKNOWN_ERROR
                $getLocationBtn.addClass 'btn-danger'
                $getLocationBtn.find('.gps-text').text ' Unknown error'
        )
      else
        $getLocationBtn.addClass 'btn-danger'
        $getLocationBtn.find('.gps-text').text ' Geolocation unavailable'
