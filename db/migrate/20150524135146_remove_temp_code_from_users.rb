class RemoveTempCodeFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :temp_code
  end
end
