class ChangeDataTradingStatusToItems < ActiveRecord::Migration[6.0]
  def up
    change_column :items, :trading_status, :integer
    rename_column :items, :trading_status, :trading_status_id
  end

  def down
    rename_column :items, :trading_status_id, :trading_status
    change_column :items, :trading_status, :string
  end
end
