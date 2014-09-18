class RenameNameInUserProfile < ActiveRecord::Migration
  def change
    rename_column :user_profiles, :name, :user_name
  end
end
