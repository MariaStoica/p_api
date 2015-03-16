class CreateGoingtoactivities < ActiveRecord::Migration
  def change
    create_table :goingtoactivities do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
    add_index :goingtoactivities, :user_id
    add_index :goingtoactivities, :activity_id
  end
end
