class AddTeamIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :team_id, :integer
    add_column :users, :username, :string, unique: true
    add_column :users, :role, :string
  end
end
