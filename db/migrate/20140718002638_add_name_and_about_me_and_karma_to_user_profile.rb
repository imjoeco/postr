class AddNameAndAboutMeAndKarmaToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :name, :string
    add_column :user_profiles, :karma, :integer
    add_column :user_profiles, :about_me, :string
  end
end
