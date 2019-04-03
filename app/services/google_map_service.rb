# frozen_string_literal: true

# Google Maps service for getting restaurant map
class GoogleMapService
  def initialize(location)
    @location = location
  end

  def get_static_map
    get_json("staticmap?zoom=17&size=400x300&markers=size:small%7Ccolor:red%7C&center=#{@location}")
  end

  # def get_java_map
  #   get_json("staticmap")
  # end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api') do |faraday|
      faraday.headers['key'] = ENV["google_maps_key"]
      faraday.adapter Faraday.default_adapter
    end
  end

end
