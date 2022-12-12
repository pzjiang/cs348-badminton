class Practice < ApplicationRecord
    # All practices belong to a team
    belongs_to :team

    # All practices have practice attendances
    has_many :practice_attendances, dependent: :destroy
    has_many :users, :through => :practice_attendances, :foreign_key => :practice_id

    validates :team_id, presence: true # This may be unnecessary
    validates :date, presence: true
    validates :location, presence: true
end
