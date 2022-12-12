class PracticeAttendance < ApplicationRecord
    
    validates :practice_id, presence: true
    # User may be on wrong team if user switched teams
    validates :user_id, presence: true
end
