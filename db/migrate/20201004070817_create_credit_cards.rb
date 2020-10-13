class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.references :user, foreign_key: true
      t.string :customer_token, null: false
      t.string :default, null: false
      t.timestamps
    end
  end
end
