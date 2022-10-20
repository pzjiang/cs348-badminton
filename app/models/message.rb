class Message < ApplicationRecord    
    validates :user_id, presence: true
    validates :team_id, presence: true
    validates :body, presence: true, length: {minimum: 1, maximum: 200}

    # Enforce valid status options
    VALID_STATUSES = ['Sent','Deleted','Deleted by Admin']
    validates :status, presence: true, inclusion: {in: VALID_STATUSES}

    def open?
        status=='Sent'
    end
end
