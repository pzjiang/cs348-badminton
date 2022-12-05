class AddIndexToUser < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :team_id
  end
end
