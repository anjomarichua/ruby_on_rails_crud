class Organisation < ApplicationRecord
	validates :name, 
		presence: true   
	validates :hourly_rate, 
		presence: true, 
		numericality: {:greater_than => 0}   
	has_many :users, dependent: :destroy
	has_many :shifts, :through => :user
end
