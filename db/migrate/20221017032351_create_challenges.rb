class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|
      t.integer :challenger_id
      t.integer :receiver_id
      t.string :status
      t.integer :game_id
      t.datetime :date_issued
      t.datetime :game_date

      t.timestamps
    end
  end
end
