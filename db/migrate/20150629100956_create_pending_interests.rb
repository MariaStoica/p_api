class CreatePendingInterests < ActiveRecord::Migration
  def change
    create_table :pending_interests do |t|
      t.text :name

      t.timestamps
    end
  end
end
