class AddFavoritedToPostRelation < ActiveRecord::Migration
  def change
    add_column :post_relations, :favorited, :boolean
  end
end
