class CreatePostWeeklyLists < ActiveRecord::Migration
  def change
    create_table :post_weekly_lists do |t|
      t.text :items

      t.timestamps
    end
  end
end
