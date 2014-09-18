class PostWeeklyList < ActiveRecord::Base
  attr_accessible :items
  serialize :items

  before_create :generate_list

  def self.last_or_create
    list = PostWeeklyList.last
    if !list || list.created_at + 1.hour < Time.now
      list = PostWeeklyList.create
    end
    return list
  end

private
  def generate_list
    post_daily_lists = Array.new
    start_index = PostDailyList.last.id
    7.times do |i|
      current_index = start_index - (i * 24)
      if current_index > 0 && post_list = PostDailyList.find(current_index)
        post_daily_lists.push(post_list)
      end
    end

    weekly_list = Array.new
    post_daily_lists.each do |post_list|
      post_list.items.each do |post|
        if i = weekly_list.index {|p| p[:id] == post[:id]}
          weekly_list[i][:vote_count] = weekly_list[i][:vote_count] + post[:vote_count]
        else
          weekly_list.push(post)
        end
      end
    end

    weekly_list.sort_by { |post| post[:vote_count] }

    self.items = weekly_list
  end
end
