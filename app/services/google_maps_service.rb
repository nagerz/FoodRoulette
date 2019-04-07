class GoogleMapsService
  def geocode(location)
    location = CGI::escape(location)
    get_json("geocode/json?address=#{location}&key=#{ENV['GOOGLE_PLACES_API_KEY']}")
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/')
  end
end
