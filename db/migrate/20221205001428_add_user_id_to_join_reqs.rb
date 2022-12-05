class AddUserIdToJoinReqs < ActiveRecord::Migration[6.1]
  def change
    add_column :join_reqs, :user_id, :integer
    add_index :join_reqs, :user_id
  end
end
