class CreateTesters < ActiveRecord::Migration[6.1]
  def change
    create_table :testers do |t|
      t.string :title
      t.text :body
      t.integer :numbered

      t.timestamps
    end
  end
end
