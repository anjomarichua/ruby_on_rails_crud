class User < ApplicationRecord  
	attr_accessor :password
	attr_accessor :password_confirmation
	before_save :encrypt_password

	validates :name, 
		presence: true
	validates :email, 
		format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :password, 
		presence: true, 
		length: {minimum:6}
	has_one :organisation
	has_many :shifts

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

end
