# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :check_login

  def show
    render locals: {
      user: UserFacade.new(current_user)
    }
  end
end
