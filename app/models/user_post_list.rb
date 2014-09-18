class UserPostList < ActiveRecord::Base
  attr_accessible :low_karma, :items, :user_id
  serialize :items
  belongs_to :user

  def add_or_update(item)
    if current = self.items.index { |post| post[:id] == item[:id] }
      self.items.delete_at(current)
    end

    if self.items.length < 30 || item[:karma] >= self.low_karma
      if self.items.length >= 30
        self.items.pop
      end
      
      new_location = self.items.index { |post| post[:karma] < item[:karma] }
      new_item = {
        title:item[:title],
        id:item[:id],
        karma:item[:karma],
        created_at:item[:created_at]
      }
      if new_location
        self.items.insert(new_location, new_item)
      else
        self.items.push(new_item)
      end

      self.low_karma = self.items.last[:karma]

      self.save
    end
  end
end
