class OrganisationsController < ApplicationController
  
  helper_method :current_user

  # GET method to get all organisations from database   
  def index   
    @organisations = Organisation.all   
  end   
   
  # GET method to get a organisation by id   
  def show 
    if(session[:organisation_id])
      @organisation = Organisation.find(session[:organisation_id])
    else
      @organisation = Organisation.find(params[:id])
    end
    
    user = User.find(session[:user_id])
    if (user.organisation_id == nil && @organisation)
      user.update_attribute(:organisation_id, @organisation.id)
    end  
  end   
   
  # GET method for the new organisation form   
  def new   
    user = User.find(session[:user_id])
    if(user.organisation != nil)
      render :show
    else
      @user_name = session[:name]
      @organisations = Organisation.all   
      @organisation = Organisation.new
    end
  end   
   
  # POST method for processing form data   
  def create   
    @organisation = Organisation.new(organisation_params)   
    if @organisation.save   
      user = User.find(session[:user_id])
      if(user && (@organisation.id != nil))
        user.update_attribute(:organisation_id, @organisation.id)
        session[:org_id] = @organisation.id
        flash[:notice] = 'Organisation added!'   
      else
        flash[:error] = 'Failed to add user to organisation!'   
      end
    else   
      flash[:error] = 'Failed to add organisation!'   
      render :new   
    end   
  end   

  def join
    @organisation = Organisation.find(params[:id])
    user = User.find(session[:user_id])
    if (user && @organisation)
      user.update_attribute(:organisation_id, @organisation.id)
      render :show
    else   
      flash[:error] = 'Failed to join organisation!'   
    end   
  end  

  def leave
    user = User.find(session[:user_id])
    if (user && @organisation)
      user.update_attribute(:organisation_id, nil)
      user.save
      render :new
    else   
      flash[:error] = 'Failed to leave organisation!'   
      render :show
    end   
  end  
   
   # GET method for editing a organisation based on id   
  def edit  
    @organisation = Organisation.find(params[:id])   
  end   
   
  # PUT method for updating in database a organisation based on id   
  def update   
    @organisation = Organisation.find(params[:id])   
    if @organisation.update_attributes(organisation_params)   
      flash[:notice] = 'Organisation updated!'   
      render :show   
    else   
      flash[:error] = 'Failed to edit organisation!'   
      render :edit   
    end   
  end   
   
  # DELETE method for deleting a organisation from database based on id   
  def destroy   
    @organisation = Organisation.find(params[:id])   
    if @organisation.delete   
      flash[:notice] = 'Organisation deleted!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to delete this organisation!'   
      render :destroy   
    end   
  end   

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
    if @current_user
      @current_user
    else
      OpenStruct.new(name: 'Guest')
    end
  end
   
  # we used strong parameters for the validation of params   
  def organisation_params   
    params.require(:organisation).permit(:name, :hourly_rate)   
  end    
end