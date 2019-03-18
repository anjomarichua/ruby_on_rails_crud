class UsersController < ApplicationController
  # GET method to get all user from database   
  def index   
    @user = User.all   
  end   

  # GET method for the new user form   
  def new   
    @user = User.new   
  end  
   
  # GET method to get a user by id   
  def login   
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end    
   
  # POST method for processing form data   
  def create   
    @user = User.new(user_params)
    if @user.save   
      flash[:notice] = 'User added!'   
      redirect_to '/users/new'
    else   
      flash[:error] = 'Failed add user!'   
      render :new   
    end   
  end   
   
   # GET method for editing a user based on id   
  def edit   
    @user = User.find(params[:id])   
  end   
   
  # PUT method for updating in database a user based on id   
  def update   
    @user = User.find(params[:id])   
    if @user.update_attributes(user_params)   
      flash[:notice] = 'User updated!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit user!'   
      render :edit   
    end   
  end    
   
  # DELETE method for deleting a user from database based on id   
  def destroy   
    @user = User.find(params[:id])   
    if @user.delete   
      flash[:notice] = 'User deleted!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to delete this user!'   
      render :destroy   
    end   
  end   
   
  # we used strong parameters for the validation of params   
  def user_params   
    params.require(:user).permit(:name, :email, :password, :password_confirmation)   
  end  
end
