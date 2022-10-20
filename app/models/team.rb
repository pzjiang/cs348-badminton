class Team < ApplicationRecord
    has_many :practices, dependent: :destroy

    # Teams need at least one letter of name
    validates :name, presence: true, length: {minimum: 1}
    validates :location, presence: true
end
