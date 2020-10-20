class FavoriteItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def self.whetherBookmarked(user_id, item_id)
    FavoriteItem.where(user_id: user_id, item_id: item_id) == []
  end
end
