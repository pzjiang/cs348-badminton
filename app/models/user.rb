class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  has_many :games, :through => :game_attendances, :foreign_key => :user_id
  has_many :practices, :through => :practice_attendances, :foreign_key => :user_id
  # Enforce valid roles

  VALID_ROLES = ['Player','Team Admin','Referee','System Admin']
  validates :role, presence: true, inclusion: {in: VALID_ROLES}
  

end
