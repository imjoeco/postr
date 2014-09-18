class AddKarmaToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :karma, :integer
  end
end
