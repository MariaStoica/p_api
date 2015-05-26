class AddCountryCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country_code, :integer
  end
end
