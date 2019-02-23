class User < ApplicationRecord
  attr_accessor :avatar_file_name
  has_many :groups
  has_many :members
  has_many :orders
  has_many :invited_members
  has_many :order_informations
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "90x90>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
