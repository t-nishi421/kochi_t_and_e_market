class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.string :family_name,      null: false
      t.string :first_name,       null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana,  null: false
      t.integer :postal_code,     null: false, limit: 8
      t.string :prefecture,       null: false
      t.string :city,             null: false
      t.string :house_number,     null: false
      t.string :building_name
      t.integer :telephone
      t.references :user,         null: false, foreign_key: true

      t.timestamps
    end
  end
end
