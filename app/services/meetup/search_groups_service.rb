class Meetup::SearchGroupsService
  
  def initialize(params)
    @location = params[:location]
    @text = params[:text]
  end

  def search
    fetch_result
  end

  private

  def request_path
    '/find/groups'
  end

  def request_params
    { location: @location, text: @text }.stringify_keys!
  end

  def connection
    Faraday.new url: API_HOST do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  def request
    connection.get do |req|
      req.url request_path
      req.params['key'] = API_KEY
      req.params.merge! request_params
    end
  end

  def parse_response(response)
    JSON.parse(response.body).map { |group| mapper(group)}
  end

  def mapper(group_raw)
    {
      thumbnail_photo:  group_raw.dig('key_photo', 'thumb_link'),
      name:             group_raw['name'],
      location:         group_raw['localized_location'],
      status:           group_raw['status'],
      category:         group_raw.dig('category', 'name')
    }
  end

  def fetch_result
    response = request
    parsed_responce = parse_response(response)
    parsed_responce
  end
end
