class FavoriteItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def self.whetherBookmarked(user_id, item_id)
    if FavoriteItem.where(user_id: user_id, item_id: item_id) == []
      false
    else
      true
    end
  end
end
