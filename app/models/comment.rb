class Comment < ActiveRecord::Base
	belongs_to :users
	belongs_to :activity

	validates :user_id, presence: true
	validates :activity_id, presence: true
	validates :content, presence: true, length: { maximum: 250 }
end
