# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.update_or_create(request.env['omniauth.auth'])
    if user.nil?
      render :'login/index'
    else
      session[:id] = user.id
      redirect_to root_path
      flash[:success] = "Welcome, #{user.first_name}!"
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_path
  end
end
