class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :customer, foreign_key: true
      t.float :price
      t.integer :status
      t.integer :frequency
      
      t.timestamps
    end
  end
end
