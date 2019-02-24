class FriendshipNotification < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"

  enum status: [:friendship_accepted, :friendship_pending, :friendship_rejected]
end
