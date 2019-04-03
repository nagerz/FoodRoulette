class YelpFacade
  def recommendation
    binding.pry
    Recommendation.new(random_restaurant)
  end

  def random_restaurant
    restaurants_data.sample
  end

  def restaurants_data
    service.restaurants(zipcode = "80202")
  end

  def service
    YelpService.new
  end
end
