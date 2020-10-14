class CreateCreditCards < ActiveRecord::Migration[6.0]
  def up
    create_table :credit_cards do |t|
      t.references :user, foreign_key: true
      t.string :customer_token, null: false
      t.timestamps
    end
  end

  def down
    drop_table :credit_cards
  end
end
