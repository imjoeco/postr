class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_name, :user_id, :karma
  validates_presence_of :content, :title, :user_name

  before_create { self.karma = 0 }
  after_create :add_to_recent_list

  has_many :comments, :dependent => :destroy
  has_many :post_favorites, :dependent => :destroy
  has_many :post_relations, :dependent => :destroy
  has_many :post_votes, :dependent => :destroy

  validates :content, length:{minimum:100}
  validates_uniqueness_of :title, :scope => :user_id

  def self.from_start(options = {})
    return Post.
             where("id >= ?", options[:start_id]).
             first(options[:per_page]).
             reverse
  end

  def self.from_end(options = {})
    return Post.
             where("id <= ?", options[:end_id]).
             last(options[:per_page]).
             reverse
  end

  def favorite_by_user(user_id)
    post_relation = PostRelation.find_or_create({
      post_id:self.id,
      user_id:user_id
    })

    if !post_relation.favorited
      if PostFavorite.create(post_id:self.id, user_id:user_id)
        UserFavoriteList.find_by_user_id(user_id).add_item(self.id, self.title)
        post_relation.update_attributes(favorited:true)

        return true
      else
        return false
      end
    else
      favorite = PostFavorite.where("post_id = ? AND user_id = ?", self.id, user_id).limit(1)[0]

      if favorite && favorite.destroy
        post_relation.update_attributes(favorited:false)
        UserFavoriteList.find_by_user_id(user_id).remove_item(self.id)

        return true
      else
        return false
      end
    end
  end

  def vote_by_user(user_id)
    post_relation = PostRelation.find_or_create({
      post_id:self.id,
      user_id:user_id
    })

    if !post_relation.voted
      if PostVote.create(post_id:self.id,user_id:user_id)
        self.increment!(:karma)
        if self.user_id != user_id
          UserProfile.find_by_user_id(self.user_id).increment!(:karma)
        end
        post_relation.update_attributes(voted:true)

        parent_post_list = UserPostList.find_by_user_id(self.user_id)
        if self.karma >= parent_post_list.low_karma
          parent_post_list.add_or_update(self)
        end

        return true
      else
        return false
      end
    else
      post_vote = PostVote.where(
          "post_id = ? AND user_id = ?", 
          self.id, 
          user_id
        )[0]

      if post_vote.destroy
        self.decrement!(:karma)
        if self.user_id != user_id
          UserProfile.find_by_user_id(self.user_id).decrement!(:karma)
        end
        post_relation.update_attributes(voted:false)

        parent_post_list = UserPostList.find_by_user_id(self.user_id)
        if self.karma + 1 >= parent_post_list.low_karma
          parent_post_list.add_or_update(self)
        end

        return true
      else
        return false
      end
    end
  end

private
  def add_to_recent_list
    UserRecentList.find_by_user_id(self.user_id).add_item(self)
  end
end
