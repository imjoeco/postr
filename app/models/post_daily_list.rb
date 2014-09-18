class PostDailyList < ActiveRecord::Base
  attr_accessible :items

  serialize :items

  before_create :generate_list

  def self.last_or_create
    list = PostDailyList.last
    if !list || list.created_at + 1.hour < Time.now
      list = PostDailyList.create
    end
    return list
  end

private
  def generate_list
    post_votes = PostVote.where("created_at BETWEEN ? AND ?", Time.now - 1.day, Time.now)
    votes_map = post_votes.map(&:post_id)
    vote_count_map = []

    votes_map.each do |post_id|
      unless vote_count_map.any? { |votes| votes[:post_id] == post_id }
        vote_count_map << {
          post_id:post_id,
          count:votes_map.count(post_id)
        }
      end
    end

    vote_count_map = vote_count_map.sort_by { |votes| votes[:count] }
    vote_count_map = vote_count_map.reverse

    posts = []
    vote_count_map.first(100).each do |vote|
      post = Post.find(vote[:post_id])
      posts << {
        title:post.title,
        id:post.id,
        karma:post.karma,
        vote_count:vote.count
      }
    end
    
    self.items = posts
  end
end
