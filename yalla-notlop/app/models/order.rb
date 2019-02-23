class Order < ApplicationRecord
  belongs_to :user
  has_many :invited_members, dependent: :destroy
  has_many :order_informations, dependent: :destroy
  enum status: [:waiting, :finished, :cancelled]
  enum meal: [:breakfast, :lunch, :dinner]
  validates_inclusion_of :status, :in => %w( waiting finished cancelled )
  validates_inclusion_of :meal, :in => %w( breakfast lunch dinner )

end
