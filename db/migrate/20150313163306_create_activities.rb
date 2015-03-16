class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :user_id
      t.string :location
      t.datetime :time
      t.integer :nrofpeopleinvited

      t.timestamps
    end
    add_index :activities, :user_id
  end
end
