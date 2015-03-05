class ApiKey < ActiveRecord::Base
	before_create :generate_access_token

	validates :user_id, presence: true, uniqueness: true
	# validates :access_token, presence: true, uniqueness: true
	# validates :expires_at, presence: true

	public

		def generate_access_token
		  	# fa-l de 30 s pt test si apoi fa-l pt 3h la vs finala
		  	self.expires_at = Time.now + 30.hours # == Time.now + 30 # Time.now + 30*60 = 30 minutes from now

			loop do
				self.access_token = SecureRandom.urlsafe_base64(nil, false)
				break self.access_token unless self.class.exists?(access_token: self.access_token)
			end
		end

		def update_access_token
			token = nil
				loop do
					token = SecureRandom.urlsafe_base64(nil, false)
					break token unless self.class.exists?(access_token: token)
				end
			if token
				self.update_attributes(access_token: token, expires_at: Time.now + 30.hours)
			end
		end

end
