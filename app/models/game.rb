class Game < ApplicationRecord

    has_many :game_attendances, dependent: :destroy

    # Ensure that the game is between two teams and that the loser has a lower score
    validates :winner_id, presence: true
    validates :loser_id, presence: true #, comparison: {other_than: :winner_id}, message: "Losing team cannot be the same as winning team"
    # add back after upgrading?
    validates :winner_score, presence: true
    validates :loser_score, presence: true# , comparison: {less_than: :winner_score}, message: "Loser must have lower score than winner"

    validates :date, presence: true
    validates :location, presence: true

    # The game is finished if it happens today or in the past
    def finished?
        :date <= DateTime.now
    end
end
