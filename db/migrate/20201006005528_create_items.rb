class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,                null: false
      t.integer :price,              null: false
      t.text :introduction,          null: false
      t.string :trading_status,      null: false
      t.references :category,        null: false, foreign_key: true
      t.references :brand,                        foreign_key: true
      t.integer :condition,          null: false
      t.integer :shipping_cost,      null: false
      t.integer :preparation_day,    null: false
      t.integer :prefecture,         null: false
      t.references :user,            null: false, foreign_key: true

      t.timestamps
    end
  end
end
