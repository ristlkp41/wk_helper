attachNewPassageAutosubmit = ->
  # Auto-submit form when input value has reached length of AHV number
  $('.zuko-passages input#passage_ahv_number').bind 'keyup', ->
    console.log "keyup #{$(this).val().length}"
    if $(this).val().length >= 16
      console.log $(this).closest('form')
      $(this).closest('form').submit()

$(document).on "turbolinks:load", attachNewPassageAutosubmit
