class User < ActiveRecord::Base

	validates :last_name,    presence: true, length: { maximum: 50 }
	validates :first_name,   presence: true, length: { maximum: 50 }
	validates :phone_number, presence: true, length: { maximum: 30 }, uniqueness: true # not sure if this is the longest phone number in the world (20 digits) - made it 30 in case + or ( are stored, too)
	validates :description,  length: { maximum: 500 }

	# the paperclip avatar (user's profile image)
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

    # def avatar_url
    #     avatar.url(:thumb)
    # end

    #password
    has_secure_password
    # validates :password, length: { minimum: 8 } # will delete when sms code login is integrated
    # edit not working if I leave validate password length

end
