class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :winner_id
      t.integer :loser_id
      t.integer :winner_score
      t.integer :loser_score
      t.datetime :date
      t.string :location

      t.timestamps
    end
  end
end
