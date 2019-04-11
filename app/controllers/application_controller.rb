# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  def check_login
    redirect_to '/login' unless current_user
  end

  def four_oh_four
    render file: 'errors/not_found', status: 404
  end
end
