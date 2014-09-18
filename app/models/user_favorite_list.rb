class UserFavoriteList < ActiveRecord::Base
  attr_accessible :items, :user_id
  belongs_to :user
  serialize :items

  def add_item(item_id, title)
    index = self.items.index { |li| li[:id] == item_id }
    unless index
      new_item = {
        id:item_id,
        title:title,
        created_at:Time.now
      }

      self.items.unshift(new_item)
      self.save
    end
  end

  def remove_item(item_id)
    index = self.items.index { |li| li[:id] == item_id }
    if index
      self.items.delete_at(index)
      self.save
    end
  end
end
