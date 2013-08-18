jQuery ->
  $("a[rel=popover]").popover()
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
