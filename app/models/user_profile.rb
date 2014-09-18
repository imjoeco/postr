class UserProfile < ActiveRecord::Base
  attr_accessible :karma, :about_me, :user_id, :user_name

  belongs_to :user
end
