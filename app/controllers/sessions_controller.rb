class SessionsController < ApplicationController

	def index  
		@user = User.all 
	end 

	def new  
		@user = User.all 
	end 

	def create
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			session[:name] = user.name

			if(user.organisation_id != nil)
				organisation = Organisation.find(user.organisation_id)
				session[:organisation_id] = organisation.id
				session[:organisation_name] = organisation.name
				redirect_to organisations_show_path
			else
				redirect_to organisations_new_path
			end
		else
			flash[:notice] = "Invalid email or password"
			render :new
		end
	end 

	def destroy
		reset_session
		redirect_to login_path
	end

end
