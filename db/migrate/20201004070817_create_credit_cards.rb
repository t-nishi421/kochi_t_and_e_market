class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.references :user, foreign: true
      t.string :customer_token, null: false
      t.timestamps
    end
  end
end
