class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :remember_token

  has_secure_password

  has_one :user_profile, :dependent => :destroy
  has_one :user_post_list, :dependent => :destroy
  has_one :user_comment_list, :dependent => :destroy
  has_one :user_recent_list, :dependent => :destroy

  has_many :post_votes, :dependent => :destroy
  has_many :post_favorites, :dependent => :destroy

  after_create :create_user_profile

  VALID_NAME_REGEX = /^[A-Za-z0-9]+(?:[_][A-Za-z0-9]+)*$/
  VALID_PASSWORD_REGEX = /^(?=.*[!@#$&*%^=+])(?=.*[0-9])(?=.*[a-z]).+|.{16,}$/i

  validates :name, 
    presence:true, 
    length:{
      maximum:20,
      minimum:3
    },
    format:{
      with:VALID_NAME_REGEX, 
      message:'may only contain letters, numbers, and underscore ("_") characters'
    },
    uniqueness:true,
    on: :create

  validates :password, 
    presence:true, 
    length:{maximum:32,minimum:6},
    format:{
      with:VALID_PASSWORD_REGEX,
      message:'must contain one letter, number, and special (!@#$&*) character or be at least 16 characters in length.'
    },
    on: :create

private
  def create_user_profile
    UserProfile.create(
      user_id:self.id,
      user_name:self.name,
      karma:1
    )
    UserRecentList.create(user_id:self.id,items:[])
    UserFavoriteList.create(user_id:self.id,items:[])
    UserPostList.create(user_id:self.id,items:[],low_karma:0)
    UserCommentList.create(user_id:self.id,items:[],low_karma:0)
  end
end
