class CreateJoinReqs < ActiveRecord::Migration[6.1]
  def change
    create_table :join_reqs do |t|
      t.string :req_name
      t.string :req_role
      t.integer :team_id
      t.string :status

      t.timestamps
    end
  end
end
