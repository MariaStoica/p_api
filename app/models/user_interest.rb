class UserInterest < ActiveRecord::Base
	belongs_to :user
	belongs_to :interest

	validates :user_id, presence: true
	validates :interest_id, presence: true
	validates_uniqueness_of :user_id, :scope => :interest_id # each row in the table must be unique otherwise there would be duplicates

end
