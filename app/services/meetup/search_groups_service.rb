class Meetup::SearchGroupsService

  include ::MeetupService

  def initialize(params)
    @location = params[:location]
    @text = params[:text]
  end

  private

  def request_path
    '/find/groups'
  end

  def request_params
    { location: @location, text: @text }.stringify_keys!
  end

  def mapper(group_raw)
    {
      thumbnail_photo:  group_raw.dig('key_photo', 'thumb_link'),
      name:             group_raw['name'],
      urlname:          group_raw['urlname'],
      location:         group_raw['localized_location'],
      status:           group_raw['status'],
      category:         group_raw.dig('category', 'name')
    }
  end

end
