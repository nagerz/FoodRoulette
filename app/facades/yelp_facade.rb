class YelpFacade
  def recommendation
    Recommendation.new(service.fetch)
  end

  def restaurant
    YelpService.fetch(zipcode = 80202)
  end
end
