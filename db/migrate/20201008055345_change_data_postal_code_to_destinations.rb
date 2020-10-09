class ChangeDataPostalCodeToDestinations < ActiveRecord::Migration[6.0]
  def up
    change_column :destinations, :postal_code, :string
  end

  def down
    change_column :destinations, :postal_code, :integer
  end
end
