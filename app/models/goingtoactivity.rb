class Goingtoactivity < ActiveRecord::Base
	belongs_to :users
	belongs_to :activities
end
