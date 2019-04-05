class YelpService

  def restaurants(zipcode)
    yelp_json("v3/businesses/search?location=#{zipcode}&radius=8000&open_now=true&price=1,2&limit=50&categories=restaurants").first[1]
  end

  def yelp_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.yelp.com/") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
      faraday.adapter  Faraday.default_adapter
    end
  end
end
