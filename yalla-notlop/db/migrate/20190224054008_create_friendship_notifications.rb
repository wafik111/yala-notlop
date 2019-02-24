class CreateFriendshipNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_notifications do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :type

      t.timestamps
    end
  end
end
