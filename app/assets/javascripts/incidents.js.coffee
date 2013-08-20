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

    $('#geocodeModal').on 'click', '.geocoded-address-choice', (e) ->
      $locationInput = $('#incident_location')
      $locationInput.val $(this).text()
      window.geocodeAddressAndRenderPreview()
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
