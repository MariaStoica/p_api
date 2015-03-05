class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :password_digest
      t.text :description
      t.attachment :avatar
      
      t.timestamps
    end
  end
end
