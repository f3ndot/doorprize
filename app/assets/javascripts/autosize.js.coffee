jQuery ->
  $('textarea.autosize').autosize
    append: "\n"

  # Apply autosize to witness and photo fields inserted into the DOM after load
  $('.simple_form').on 'cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem).find('textarea').autosize
      append: "\n"

  $('.simple_form').on 'cocoon:before-remove', (e, item) ->
    $(item).find('textarea').trigger 'autosize.destroy'
