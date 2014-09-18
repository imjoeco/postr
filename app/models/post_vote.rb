class PostVote < ActiveRecord::Base
  attr_accessible :post_id, :user_id

  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, :scope => :user_id
end
