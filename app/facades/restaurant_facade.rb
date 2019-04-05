class RestaurantFacade
  def recommendation
    restaurant = random_restaurant[0]
    if new_restaurant(restaurant).save
      Recommendation.new(restaurant)
    else
      recommendation
    end
  end

  def group_recommendations
    restaurants = random_restaurant(3)
    reccommendations = []
    restaurants.each do |restaurant|
      if new_restaurant(restaurant).save
        reccommendations << Recommendation.new(restaurant)
      else
        group_recommendations
      end
    end
    reccommendations
  end

  def new_restaurant(restaurant)
    Restaurant.new(yelp_id: restaurant[:id],
                   name: restaurant[:name],
                   address_1: restaurant[:location][:address1],
                   address_2: restaurant[:location][:address2],
                   address_3: restaurant[:location][:address3],
                   city: restaurant[:location][:city],
                   state: restaurant[:location][:state],
                   zip_code: restaurant[:location][:zip_code],
                   country: restaurant[:location][:country],
                   phone: restaurant[:phone],
                   image_url: restaurant[:image_url],
                   rating: restaurant[:rating],
                   price: restaurant[:price],
                   latitude: restaurant[:coordinates][:latitude],
                   longitude: restaurant[:coordinates][:longitude],
                   reviews: restaurant[:review_count],
                   category_1: restaurant[:categories][0][:title]
                   # category_2: restaurant[:categories][1][:title],
                   # category_3: restaurant[:categories][2][:title]
                )
  end

  def random_restaurant(limit = 1)
    restaurants_data.sample(limit)
  end

  def restaurants_data
    service.restaurants(zipcode = "80202")
  end

  def service
    YelpService.new
  end
end
