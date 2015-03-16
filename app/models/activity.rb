class Activity < ActiveRecord::Base
	has_many :goingtoactivities
	has_many :users, through: :goingtoactivities

	validates :user_id, presence: true
	validates :name, presence: true
	validates :location, presence: true
	validates :time, presence: true
	validates :nrofpeopleinvited, presence: true
end
