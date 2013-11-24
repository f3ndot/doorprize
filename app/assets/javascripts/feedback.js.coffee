jQuery ->
  $bugReportBtn = $('#bugReportBtn')
  $bugReportTextfield = $('#bugReportTextfield')
  $bugReportEmail = $('#bugReportEmail')
  $bugReportErrorField = $('#bugReportErrorField')

  isReady = ->
    if $bugReportTextfield.val().length > 0 and $bugReportEmail.val().length > 0 and document.getElementById('bugReportEmail').checkValidity()
      $bugReportBtn.removeClass 'disabled'
      $bugReportBtn.data 'ready', true
    else 
      $bugReportBtn.addClass 'disabled'
      $bugReportBtn.data 'ready', false

  $bugReportTextfield.on 'keyup', ->
    isReady()

  $bugReportEmail.on 'keyup', ->
    isReady()

  $bugReportBtn.click (e) ->
    # e.preventDefault() # keeps the form from submittion
    return if $bugReportBtn.data('ready') == false or $bugReportBtn.data('ready') == undefined
    $bugReportBtn.data 'ready', false
    $bugReportBtn.html '<i class="icon-refresh icon-spin"></i> Sending...'
    $bugReportBtn.addClass 'disabled'
    $bugReportBtn.attr 'disabled', true

    $.ajax '/feedback',
      type: 'POST',
      dataType: 'json',
      data:
        message: $bugReportTextfield.val()
        email: $bugReportEmail.val()
      error: (jqXHR, textStatus, errorThrown) ->
        $bugReportBtn.html '<i class="icon-warning-sign"></i> Error sending report'
        $bugReportBtn.removeClass 'btn-primary'
        $bugReportBtn.addClass 'btn-danger'
        $bugReportTextfield.addClass 'disabled'
        $bugReportTextfield.attr 'disabled', true
        $bugReportTextfield.attr 'readonly', true
        $bugReportEmail.addClass 'disabled'
        $bugReportEmail.attr 'disabled', true
        $bugReportEmail.attr 'readonly', true
        $bugReportErrorField.removeClass 'hidden'
        if jqXHR.responseText.length > 0
          $bugReportErrorField.find('.errorCode').removeClass 'hidden'
          $bugReportErrorField.find('.errorCode strong').text jqXHR.responseText
        console.log jqXHR
        console.log textStatus
        console.log errorThrown
      success: (data, textStatus, jqXHR) ->
        $bugReportBtn.button 'complete'
        $bugReportBtn.removeClass 'btn-primary'
        $bugReportBtn.addClass 'btn-success'
        $bugReportBtn.html '<i class="icon-ok"></i> Sent!'
        $bugReportTextfield.height 20
        $bugReportTextfield.addClass 'disabled'
        $bugReportTextfield.attr 'disabled', true
        $bugReportTextfield.attr 'readonly', true
        $bugReportTextfield.val data
        $bugReportTextfield.html data
