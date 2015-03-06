class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.integer :category_id

      t.timestamps
    end
    add_index :interests, :category_id
  end
end
