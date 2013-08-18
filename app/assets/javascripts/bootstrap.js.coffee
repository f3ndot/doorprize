jQuery ->
  $("a[rel=popover]").popover()
  $("a[rel=scorepopover]").popover
    html: true
    trigger: 'hover focus'
    container: 'body'
  # $(".tooltip").tooltip()
  $("a[rel=tooltip], span[rel=tooltip]").tooltip()
  $(".required abbr").tooltip()
  $("i[rel=tooltip]").tooltip()
  $("a.account-toggle").tooltip
    placement: 'bottom'
    container: 'body'

  $('[data-behaviour=datetime_picker]').datetimepicker
    pick12HourFormat: true
    pickSeconds: false
