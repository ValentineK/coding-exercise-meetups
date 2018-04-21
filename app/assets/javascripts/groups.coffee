# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.name a').on 'click', (event, element) ->
    group_name_text = @text
    $.get this.href, (data) ->
      $('.events-replacable').html(data)
      console.log(group_name_text)
      $('.events-replacable .meetup_name').html(group_name_text)
    false
