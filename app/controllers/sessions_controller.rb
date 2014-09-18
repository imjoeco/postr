class SessionsController < ApplicationController
  respond_to :json

  def create
    if cookies[:user_id].present?
      user = User.find(cookies[:user_id])
    end

    unless user && user.name == params[:session][:name]
      user = User.find_by_name(params[:session][:name])
    end

    if !user.nil? && user.authenticate(params[:session][:password])
      sign_in(user)
      head :ok
    elsif user.nil?
      head :not_found
    else
      head :unauthorized
    end
  end

  def destroy
    user = current_user
    if user
      user.update_attributes(:remember_token => nil)
      cookies.delete(:remember_token)
      cookies.delete(:user_name)

      head :ok
    else
      head :unauthorized
    end
  end
end
