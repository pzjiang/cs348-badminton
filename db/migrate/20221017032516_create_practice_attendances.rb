class CreatePracticeAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :practice_attendances do |t|
      t.integer :practice_id
      t.integer :user_id

      t.timestamps
    end
  end
end
