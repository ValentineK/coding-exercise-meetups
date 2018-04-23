class Meetup::Base

  # It took pretty much time of ivestigation to get the decision where should
  # Meetup API functuanality be.
  #
  # It can be lib, Model or Service and still can be a topic to talk about.
  #
  # I considered that this is a Service since it does not directly manages the data
  # it just grabs and aggregates the data.
  #
  # It is also still easy to extend or reuse.
  #
  # For bigger project or API functionality it can be considered to use or
  # write gem. Actually it is one on github, however it is no activity there for more
  # than a year.

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
      # I have not concerned exceptions here or in networking due it is
      # not part of the task, but I can propose how to carry it if needed
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

  # should retern path of the api uri request for example /find/groups
  # for the request https://api.meetup.com/find/groups?key=0&location=Munich&text=ruby
  def request_path
    raise 'You have to implement this method in the service file.'
  end

  # should retern hash with GET parameters for api request, keys should be a strings
  # for example:
  # {
  #   'location'=> 'Munich'
  #   'text' => 'ruby'
  # }
  # for the request https://api.meetup.com/find/groups?key=0&location=Munich&text=ruby
  def request_params
    raise 'You have to implement this method in the service file.'
  end

  # should return a hash with mapping
  #
  # for example:
  # {
  #   thumbnail_photo:  group_raw.dig('key_photo', 'thumb_link'),
  #   name:             group_raw['name'],
  # }
  #
  # will map from response array ['key_photo']['thumb_link'] to [:thumbnail_photo]
  # and ['name'] to [:name]
  def mapper(group_raw)
    raise 'You have to implement this method in the service file.'
  end

end
