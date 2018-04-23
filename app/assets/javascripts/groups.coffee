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
