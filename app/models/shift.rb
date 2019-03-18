class Shift < ApplicationRecord   
	validates :user_id, 
		presence: true   
	validates :start, 
		presence: true
	validates :finish, 
		presence: true  
	validates :break_length, 
		presence: true
	belongs_to :user
end   