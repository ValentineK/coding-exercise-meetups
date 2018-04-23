# I find this idea to load the whole partial to show the events not the ideal. I remember
# we spoke on the interview about messaging system in RoR, and during preparing to the
# task I saw different options to approach with events, but I realized that It is better
# to make it done with the way that I already know due I had a limited time.
# As minimum it works

jQuery ->
  events = $('.search-results .events')

  close_events = () ->
    events.find('.events-list').empty()
    events.hide()

  $('.name a').on 'click', (event, element) ->
    close_events()
    group_name_text = @text
    $.get @href, (data) ->
      events.find('.events-list').html(data)
      events.find('.meetup_name').text(group_name_text)
      events.show()
    false

  $('.search-results .destroy-past-events').click () ->
    close_events()
    false
