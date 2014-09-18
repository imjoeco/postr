class PostRelation < ActiveRecord::Base
  attr_accessible :comment_count, :post_id, :user_id, 
    :voted, :voted_comments, :favorited

  before_create :init
  serialize :voted_comments

  belongs_to :post

  def add_or_remove_comment(comment_id)
    if comment_index = self.voted_comments.index(comment_id)
      self.voted_comments.delete_at(comment_index)
    else
      self.voted_comments.push(comment_id)
    end

    self.save
  end

  def self.find_or_create(options = {})
    if !options[:user_id].nil? && !options[:post_id].nil?
      if post_relation = PostRelation.where(
          "post_id = ? AND user_id = ?",
          options[:post_id],
          options[:user_id]
        ).limit(1)[0]

        return post_relation
      else
        return PostRelation.create(
          post_id:options[:post_id], 
          user_id:options[:user_id]
        )
      end
    else
      return false
    end
  end

private
  def init
    self.comment_count ||= 0
    self.voted ||= false
    self.favorited ||= false
    self.voted_comments ||= []
  end
end
