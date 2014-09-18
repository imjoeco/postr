class RenameDailyTopList < ActiveRecord::Migration
  def change
    rename_table :daily_top_lists, :post_top_daily_lists
  end
end
