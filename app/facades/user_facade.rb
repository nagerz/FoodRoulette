class UserFacade
  attr_reader :name,
              :email,
              :thumbnail

  def initialize(current_user)
    @user = current_user
    @name = current_user.first_name
    @email = current_user.email
    @thumbnail = current_user.thumbnail
  end

  def visited_restaurants
    @user.restaurants.limit(5)
  end

end
