class AddLatestActivitiesToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :latest_activities, :text
  end
end
