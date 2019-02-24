class User < ApplicationRecord
  has_many :groups
  has_many :members
  has_many :orders
  has_many :invited_members
  has_many :order_informations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
