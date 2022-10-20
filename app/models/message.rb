class Message < ApplicationRecord
    # Enforce valid status options
    VALID_STATUSES = ['Sent','Deleted','Deleted by Admin']
    validates :status, presence: true, inclusion: {in: VALID_STATUSES}

    def visible_all?
        status=='Sent'
    end
end
