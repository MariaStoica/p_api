class Activity < ActiveRecord::Base
	has_many :goingtoactivities
	has_many :users, through: :goingtoactivities
	has_many :comments

	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 30 }
	validates :description, length: { maximum: 250 }
	validates :location, presence: true
	validates :time, presence: true
	validates :nrofpeopleinvited, presence: true
end
