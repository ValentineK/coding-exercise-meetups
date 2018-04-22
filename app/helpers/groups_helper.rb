module GroupsHelper

  def page_title
    # Its a bit ugly here, I usualliy use gem 'meta-tags', but since it is only two pages...
    ['Meetup client', @search_text, @search_text.nil?? '' : 'Search results'].join(' - ')
  end

end
