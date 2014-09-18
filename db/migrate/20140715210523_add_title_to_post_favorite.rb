class AddTitleToPostFavorite < ActiveRecord::Migration
  def change
    add_column :post_favorites, :title, :string
  end
end
