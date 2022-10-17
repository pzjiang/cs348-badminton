class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :team_id
      t.text :body
      t.string :status

      t.timestamps
    end
  end
end
