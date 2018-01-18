class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :item, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :payment_mode
      t.integer :payment_status
      t.integer :order_status

      t.timestamps null: false
    end
  end
end
