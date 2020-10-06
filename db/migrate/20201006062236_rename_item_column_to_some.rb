class RenameItemColumnToSome < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :condition, :condition_id
    rename_column :items, :shipping_cost, :shipping_cost_id
    rename_column :items, :preparation_day, :preparation_day_id
    rename_column :items, :prefecture, :prefecture_id
  end
end
