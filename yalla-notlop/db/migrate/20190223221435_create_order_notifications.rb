class CreateOrderNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :order_notifications do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :type
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
