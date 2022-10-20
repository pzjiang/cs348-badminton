class JoinReq < ApplicationRecord
    # Enforce valid roles
    VALID_ROLES = ['Player','Team Admin','Referee','System Admin']
    validates :role, presence: true, inclusion: {in: VALID_ROLES}

    # Enforce valid status options
    VALID_STATUSES = ['Pending','Accepted','Deleted']
    validates :status, presence: true, inclusion: {in: VALID_STATUSES}
end
