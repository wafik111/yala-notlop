class RenameTypeColumnOfOrderNotification < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_notifications, :type, :status
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
