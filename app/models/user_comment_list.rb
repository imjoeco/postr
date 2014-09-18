class UserCommentList < ActiveRecord::Base
  attr_accessible :items, :low_karma, :user_id
  belongs_to :user
  serialize :items

  def add_or_update(new_item)
    if current = self.items.index { |item| item[:id] == new_item[:id] }
      self.items.delete_at(current)
    end

    if self.items.length < 30 || new_item[:karma] >= self.low_karma
      if self.items.length >= 30
        self.items.pop
      end
      
      new_item = {
        content:new_item[:content],
        post_id:new_item[:post_id],
        id:new_item[:id],
        karma:new_item[:karma],
        created_at:new_item[:created_at]
      }

      new_location = self.items.index { |item| item[:karma] < new_item[:karma] }

      if new_location
        self.items.insert(new_location, new_item)
      else
        self.items.push(new_item)
      end

      self.low_karma = self.items.last[:karma]

      return self.save
    else
      return false
    end
  end

  def update_comment(item)
    if current = self.items.index { |item| item.id == new_item.id }
      self.items.delete_at(current)
    end
  end
end
