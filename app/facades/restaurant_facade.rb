# frozen_string_literal: true

class RestaurantFacade
  def recommendation(location)
    restaurant_data = random_restaurant(location)[0]
    make_recommendation(restaurant_data) || recommendation(location)
  end

  def group_recommendations(location)
    restaurants_data = random_restaurant(location, 3)

    recommendations = []
    restaurants_data.each do |restaurant_data|
      if make_recommendation(restaurant_data)
        recommendations << make_recommendation(restaurant_data)
      else
        group_recommendations(location)
      end
    end
    recommendations
  end

  def make_recommendation(restaurant_data)
    if existing_restaurant(restaurant_data)
      Recommendation.new(restaurant_data, existing_restaurant(restaurant_data))
    elsif new_restaurant(restaurant_data).save
      Recommendation.new(restaurant_data, Restaurant.last)
    end
  end

  def new_restaurant(restaurant_data)
    Restaurant.new(yelp_id: restaurant_data[:id],
                   name: restaurant_data[:name],
                   address_1: restaurant_data[:location][:address1],
                   address_2: restaurant_data[:location][:address2],
                   address_3: restaurant_data[:location][:address3],
                   city: restaurant_data[:location][:city],
                   state: restaurant_data[:location][:state],
                   zip_code: restaurant_data[:location][:zip_code],
                   country: restaurant_data[:location][:country],
                   phone: restaurant_data[:phone],
                   image_url: restaurant_data[:image_url],
                   rating: restaurant_data[:rating],
                   price: restaurant_data[:price],
                   latitude: restaurant_data[:coordinates][:latitude],
                   longitude: restaurant_data[:coordinates][:longitude],
                   reviews: restaurant_data[:review_count],
                   category_1: restaurant_data[:categories][0][:title],
                   url: restaurant_data[:url])
    # category_2: restaurant[:categories][1][:title],
    # category_3: restaurant[:categories][2][:title]
  end

  def random_restaurant(location, limit = 1)
    restaurants_data(location).sample(limit)
  end

  def existing_restaurant(restaurant_data)
    Restaurant.find_by(yelp_id: restaurant_data[:id])
  end

  def restaurants_data(location)
    service.restaurants(location)
  end

  def service
    YelpService.new
  end
end
