class AddTempCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :temp_code, :string
  end
end
