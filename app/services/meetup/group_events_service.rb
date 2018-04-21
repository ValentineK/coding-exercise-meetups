class Meetup::GroupEventsService

  include ::MeetupService

  def initialize(params)
    @group_urlname = params[:group_urlname]
  end

  private

  def request_path
    "/#{@group_urlname}/events"
  end

  def request_params
    {
      'sign': true,
      'photo-host': 'public',
      'desc': true,
      'status': 'past'
    }
  end

  def mapper(group_raw)
    {
      date: group_raw['local_date'],
      time: group_raw['local_time'],
      venue_name: group_raw.dig('venue', 'name'),
      yes_rsvp_count: group_raw['yes_rsvp_count']
    }
  end
end
