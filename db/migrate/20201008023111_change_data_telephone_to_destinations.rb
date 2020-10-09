class ChangeDataTelephoneToDestinations < ActiveRecord::Migration[6.0]
  def up
    change_column :destinations, :telephone, :string
  end

  def down
    change_column :destinations, :telephone, :integer
  end
end
