class Challenge < ApplicationRecord
    # There is a point when no challenger_id exists because it must be populated automatically
    # validates :challenger_id, presence: true

    # Team cannot challenge itself
    validates :receiver_id, presence: true, comparison: {other_than: :challenger_id}, message: "Team cannot challenge itself"

    # Enforce valid status options
    VALID_STATUSES = ['Pending','Accepted','Rejected','Withdrawn']
    validates :status, presence: true, inclusion: {in: VALID_STATUSES}

    validates :game_id # This value can be missing

    validates :date_issued, presence: true
    validates :game_date, presence: true

    def active?
        status=='Pending'
    end
end
