class AddColumnDefaultToDestination < ActiveRecord::Migration[6.0]
  def up
    add_column :destinations, :use, :boolean, default: false, null: false
  end

  def down
    remove_column :destinations, :use
  end
end
