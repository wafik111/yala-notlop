class FriendshipNotification < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"

  enum status: [:read, :unread]
  enum notification_type: [:friendship_accepted, :friendship_pending]

end
