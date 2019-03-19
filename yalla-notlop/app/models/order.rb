class Order < ApplicationRecord

  #relationships
  belongs_to :user
  has_many :invited_members, dependent: :destroy
  has_many :order_informations, dependent: :destroy
  has_many :order_notifications, dependent: :destroy
  has_attached_file :menu, styles: { large: "900x900>", thumb: "100x100>" }

  #enumarations
  enum status: [:waiting, :finished, :cancelled]
  enum meal: [:breakfast, :lunch, :dinner]
  
  #calidations
  validates_attachment_content_type :menu, content_type: /\Aimage\/.*\z/
  validates_inclusion_of :status, :in => %w( waiting finished cancelled )
  validates_inclusion_of :meal, :in => %w( breakfast lunch dinner )
  validates :name, presence: true 
  validates :ends_at, presence: true
  validates :meal, presence: true 
  validates :resturant, presence: true 
  validates :menu, presence: true 
  validate :ends_at_in_future

  def ends_at_in_future
    errors.add(:ends_at, "must be some date in the future.") if ends_at <= DateTime.now
  end
  
end
