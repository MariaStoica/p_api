class Goingtoactivity < ActiveRecord::Base
	belongs_to :users
	belongs_to :activities

	validates :user_id, presence: true
	validates :activity_id, presence: true
	validates_uniqueness_of :user_id, :scope => :activity_id # each row in the table must be unique otherwise there would be duplicates
end
