class OrderNotification < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
  belongs_to :order
  enum type: [:read, :unread]
end
