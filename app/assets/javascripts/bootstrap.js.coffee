jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip], span[rel=tooltip]").tooltip()
  $(".required abbr").tooltip()

  $('[data-behaviour=datetime_picker]').datetimepicker
    pick12HourFormat: true
    pickSeconds: false
