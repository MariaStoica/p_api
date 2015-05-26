class UpdateUsersAfterTwilio < ActiveRecord::Migration
  def change
  	remove_column :users, :password_digest
  	change_column :users, :country_code, :string
  end
end
