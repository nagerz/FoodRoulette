class UsersController < ApplicationController
  def show
    render locals: {
      user: UserFacade.new(current_user)
    }
  end
end
