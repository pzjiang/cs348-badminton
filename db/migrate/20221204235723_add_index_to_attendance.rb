class AddIndexToAttendance < ActiveRecord::Migration[6.1]
  def change
    add_index :practice_attendances, :practice_id
    add_index :practice_attendances, :user_id
    add_index :practices, :team_id
    add_index :messages, :team_id
    add_index :join_reqs, :team_id
    add_index :game_attendances, :game_id
    add_index :challenges, :receiver_id
  end
end
