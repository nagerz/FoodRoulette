class YelpService
  attr_reader :zipcode

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def self.fetch(zipcode)
    new(zipcode).fetch
  end

  def fetch
    body
  end

  def body
    JSON.parse(conn.response.body)
  end

  def conn
    Faraday.new(:url => "https://api.yelp.com/v3/businesses/search?location=#{zipcode}") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
      faraday.adapter  Faraday.default_adapter
    end
  end
end
