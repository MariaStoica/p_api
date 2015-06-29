class User < ActiveRecord::Base
    has_many :user_interests
    has_many :interests, through: :user_interests

    validates :country_code, presence: true, length: { maximum: 4, minimum: 2 } # because there's + and then a number between 1 and 999
	validates :phone_number, presence: true, length: { maximum: 30 }# not sure if this is the longest phone number in the world (20 digits) - made it 30 in case + or ( are stored, too)
	validates_uniqueness_of :phone_number, :scope => :country_code # the country code together with the phone number must be unique

	validates :last_name,    presence: true, length: { maximum: 50 }
	validates :first_name,   presence: true, length: { maximum: 50 }	
	validates :description,  length: { maximum: 250 }

	# the paperclip avatar (user's profile image)
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

    #contains the twilio one time sms password
    has_secure_password

end
