class PostsController < ApplicationController
  respond_to :json

  def create
    if user = current_user
      post = Post.new(params[:post])
      post.user_id = user.id
      post.user_name = user.name
      if post.save
        UserRecentList.find_by_user_id(user.id).add_item(post)
        post.vote_by_user(user.id)
        respond_with post
      else
        render :json => { errors: post.errors.full_messages }, status:406
      end
    else
      head :unauthorized
    end
  end

  def update
    if user = current_user
      post = Post.find(params[:id])
      if post.user_id == user.id
        post.update_attributes(
          title:params[:post][:title],
          content:params[:post][:content]
        )

        head :ok
      else
        head :not_modified
      end
    else
      head :unauthorized
    end
  end

  def show
    respond_with Post.find(params[:id])
  end

  def index
    # Load newer from start id
    if params[:start_post].present?
      posts = Post.from_start(start_id:params[:start_post],per_page:5)
    # Load older from ending id
    elsif params[:end_post].present?
      posts = Post.from_end(end_id:params[:end_post], per_page:5)
    else
      posts = Post.last(5).reverse
    end
    respond_with posts
  end

#=================== Collection Actions ====================

  def daily
    respond_with PostDailyList.last_or_create
  end

  def weekly
    respond_with PostWeeklyList.last_or_create
  end

  def favorites
    if user = current_user
      respond_with UserFavoriteList.find_by_user_id(user.id)
    else
      head :unauthorized
    end
  end

#==================== Member Actions =======================

  def post_relation
    if user = current_user
      respond_with PostRelation.find_or_create(post_id:params[:id],user_id:user.id)
    else
      head :unauthorized
    end
  end

  def favorite
    if user = current_user
      post = Post.find(params[:id])
      if post.favorite_by_user(user.id)
        head :ok
      else
        head :not_modified
      end
    else
      head :unauthorized
    end
  end

  def vote
    if user = current_user
      post = Post.find(params[:id])
      if post.vote_by_user(user.id)
        head :ok
      else
        head :not_modified
      end
    else
      head :unauthorized
    end
  end
end
