class UserRecentList < ActiveRecord::Base
  attr_accessible :items, :user_id
  serialize :items
  belongs_to :user

  def add_item(item)
    if self.items.length >= 30
      self.items.pop
    end

    new_item = {
      id:item.id,
      content:item.content,
      created_at:item.created_at
    }

    if !item[:title].nil?
      new_item[:title] = item[:title]
    end

    if !item[:post_id].nil?
      new_item[:post_id] = item[:post_id]
    end

    self.items.unshift(new_item)
    self.save
  end
end
