class Meetup::Base

  API_HOST = 'https://api.meetup.com'
  API_KEY = ENV['MEETUP_API_KEY']
  API_CACHE_EXPIRE_TIME = 5.minutes

  def run!
    response = request!
    if response.status == 200
      map_parsed_response(parse_response(response))
    else
      raise Exception.new('Unexpected respond from Meetup API Host')
      # TODO: Extend the error description
    end
  end

  private

  def connection
    Faraday.new url: API_HOST do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def parse_response(response)
    JSON.parse(response.body)
  end

  def map_parsed_response(parsed_response)
    parsed_response.map{ |group| mapper(group) }
  end

  def request!
    Rails.cache.fetch(request_cache_key, expires_in: API_CACHE_EXPIRE_TIME) do
      connection.get do |req|
        req.url request_path
        req.params['key'] = API_KEY
        req.params.merge! request_params
      end
    end
  end

  def request_cache_key
    ['meetup_api', request_path, request_params]
  end

  def request_path
    raise 'You have to implement this method in the service file.'
  end

  def request_params
    raise 'You have to implement this method in the service file.'
  end

  def mapper(group_raw)
    raise 'You have to implement this method in the service file.'
  end

end
