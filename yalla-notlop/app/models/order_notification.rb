class OrderNotification < ApplicationRecord

  #relationships
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
  belongs_to :order

  #enumerations
  enum status: [:read, :unread]
  enum notification_type: [:order_finished, :order_cancelled, :order_invitation]
end
