class CommentsController < ApplicationController
  respond_to :json

  def create
    user = current_user
    if user
      post_relation = PostRelation.find_or_create({
           post_id:params[:comment][:post_id],
           user_id:user.id
      })

      if post_relation.comment_count == 0
        comment = Comment.new(params[:comment])
        comment.user_id = user.id
        comment.user_name = user.name

        if comment.save
          post_relation.update_attribute(:comment_count,comment.content.length)
          comment.vote_by_user(user.id)

          respond_with comment
        else
          head :bad_request
        end
      else
        head :not_modified
      end
    else
      head :unauthorized
    end
  end

  def index
    respond_with Comment.all_by_post(params[:post_id])
  end

# Member actions
  def vote
    user = current_user
    if user
      comment = Comment.find(params[:id])
      if comment.vote_by_user(user.id)
        head :ok
      else
        head :not_modified
      end
    else
      head :unauthorized
    end
  end
end
