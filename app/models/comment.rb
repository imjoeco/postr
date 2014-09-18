class Comment < ActiveRecord::Base
  attr_accessible :content, :karma, :user_id, :user_name, :post_id
  belongs_to :post

  before_create :init
  after_create :check_recent_list

  def self.all_by_post(post_id)
    return Comment.
             where("post_id = ?", post_id).
             order("created_at DESC")
  end

  def vote_by_user(user_id)
    post_relation = PostRelation.find_or_create({
      post_id:self.post_id,
      user_id:user_id
    })

    if !post_relation.voted_comments.include?(self.id)
      self.karma = self.karma + 1
      if self.user_id != user_id
        UserProfile.find_by_user_id(self.user_id).increment!(:karma)
      end
    else
      self.karma = self.karma - 1
      if self.user_id != user_id
        UserProfile.find_by_user_id(self.user_id).decrement!(:karma)
      end
    end

    post_relation.add_or_remove_comment(self.id)

    if UserCommentList.find_by_user_id(self.user_id).add_or_update(self)
      return self.save
    else
      return false
    end
  end

private
  def init
    self.karma ||= 0
  end

  def check_recent_list
    UserRecentList.find_by_user_id(self.user_id).add_item(self)
  end
end
