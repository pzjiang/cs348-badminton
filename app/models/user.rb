class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enforce valid roles
  VALID_ROLES = ['Player','Team Admin','Referee','System Admin']
  validates :role, presence: true, inclusion: {in: VALID_ROLES}
end
