class YelpService

  def restaurants(location)
    if location.include?('|')
      latitude = location.split("|")[0]
      longitude = location.split("|")[1]
      yelp_json("v3/businesses/search?latitude=#{latitude}&longitude=#{longitude}&radius=8000&open_now=true&price=1,2&limit=50&categories=restaurants").first[1]
    else
      yelp_json("v3/businesses/search?location=#{location}&radius=8000&open_now=true&price=1,2&limit=50&categories=restaurants").first[1]
    end
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
