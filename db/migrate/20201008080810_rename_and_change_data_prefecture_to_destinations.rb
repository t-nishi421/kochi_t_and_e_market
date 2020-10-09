class RenameAndChangeDataPrefectureToDestinations < ActiveRecord::Migration[6.0]
  def up
    change_column :destinations, :prefecture, :integer
    rename_column :destinations, :prefecture, :prefecture_id
  end

  def down
    rename_column :destinations, :prefecture_id, :prefecture
    change_column :destinations, :postal_code, :string
  end
end
