class CreatePractices < ActiveRecord::Migration[6.1]
  def change
    create_table :practices do |t|
      t.integer :team_id
      t.datetime :date
      t.string :location

      t.timestamps
    end
  end
end
