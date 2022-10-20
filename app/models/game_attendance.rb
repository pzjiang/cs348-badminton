class GameAttendance < ApplicationRecord
    belongs_to :game

    validates :game_id, presence: true
    # User may be on wrong team if user switched teams
    validates :user_id, presence: true
end
