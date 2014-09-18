class ApplicationController < ActionController::Base
	def current_user
    if cookies[:remember_token].present? && cookies[:user_id].present?
      current_user = User.find(cookies[:user_id])
      if current_user.remember_token == cookies[:remember_token]
        return current_user
      else
        return false
      end
    else
      return false
    end
	end

  def sign_in(user)
    reset_session

    if user.remember_token.nil?
      user.update_attributes(
        remember_token:SecureRandom.urlsafe_base64
      )
    end
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:user_name] = user.name
    cookies.permanent[:remember_token] = user.remember_token
  end
end
