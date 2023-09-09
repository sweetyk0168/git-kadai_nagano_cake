class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null:false
      t.string :postcode, null:false
      t.text :address, null:false
      t.string :name, null:false
      t.integer :postage, null:false
      t.integer :payment, null:false
      t.integer :payment_method, default: 0
      t.integer :order_status ,default: 0
      t.timestamps
    end
  end
end
