jQuery ->
  $('.name a').on 'click', (event, element) ->
    $('.search-results .events').html(' ')
    group_name_text = @text
    $.get this.href, (data) ->
      $('.search-results .events').html(data)
      $('.search-results .events .meetup_name').html(group_name_text)
    false
