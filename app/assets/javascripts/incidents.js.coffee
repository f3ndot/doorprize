# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("input#incident_severity").on 'change', (e) ->
    severity = $(this).val()
    severity_text = $('.severity-levels .severity[data-level=' + severity + ']').text()
    $('.incident_severity .help-block').text severity_text
