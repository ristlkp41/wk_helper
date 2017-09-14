attachAttendeesServiceMembersPolling = ->
  if $('.zuko-attendees #service-members a.refresh').length > 0
    setTimeout ( ->
      $('.zuko-attendees #service-members a.refresh').trigger('click')
    ), 5000

window.attachAttendeesServiceMembersPolling = attachAttendeesServiceMembersPolling

$(document).on "turbolinks:load", attachAttendeesServiceMembersPolling
