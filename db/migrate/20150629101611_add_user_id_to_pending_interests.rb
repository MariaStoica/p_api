class AddUserIdToPendingInterests < ActiveRecord::Migration
  def change
    add_column :pending_interests, :user_id, :integer
    add_index :pending_interests, :user_id
  end
end
