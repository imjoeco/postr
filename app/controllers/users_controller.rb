class UsersController < ApplicationController
  respond_to :json

  def create
    user = User.new(params[:user])
    if user.save
      sign_in(user)
      user.password_digest = "[FILTERED]"
      user.remember_token = "[FILTERED]"

      respond_with user
    else
      render :json => { errors: user.errors.full_messages }, status:403
    end
  end

  def show
    user_profile = UserProfile.find_by_user_id(params[:id])
    user = {
      name:user_profile.user_name,
      id:params[:id],
      karma:user_profile.karma,
      about_me:user_profile.about_me,
      created_at:user_profile.created_at
    }

    respond_with user
  end

  def update
    user = current_user
    if user
      if user.user_profile.update_attributes(about_me:params[:about_me])
        head :ok
      else
        head :not_modified
      end
    else
      head :unauthorized
    end
  end

# Member actions
  def recent_list
    respond_with UserRecentList.find_by_user_id(params[:id])
  end

  def top_comments
    respond_with UserCommentList.find_by_user_id(params[:id])
  end

  def top_posts
    respond_with UserPostList.find_by_user_id(params[:id])
  end
end
