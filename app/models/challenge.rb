class Challenge < ApplicationRecord
    # Enforce valid status options
    VALID_STATUSES = ['Pending','Accepted','Rejected','Withdrawn']
    validates :status, presence: true, inclusion: {in: VALID_STATUSES}
end
