class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.text :name, unique: true
      t.string :location

      t.timestamps
    end
  end
end
