class CreateDailyTopLists < ActiveRecord::Migration
  def change
    create_table :daily_top_lists do |t|
      t.text :posts

      t.timestamps
    end
  end
end
