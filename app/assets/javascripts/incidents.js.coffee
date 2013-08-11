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