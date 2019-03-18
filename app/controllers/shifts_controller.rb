class ShiftsController < ApplicationController
  # GET method to get all shifts from database   
  def index   
    @shifts = Shift.all   
  end   
   
  # GET method to get a organisation by id   
  def show   
    @organisation = Shift.find(params[:id])   
  end   
   
  # GET method for the new organisation form   
  def new   
    @organisation = Shift.new   
  end   
   
  # POST method for processing form data   
  def create   
    @organisation = Shift.new(organisation_params)   
    if @organisation.save   
      flash[:notice] = 'Shift added!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit shift!'   
      render :new   
    end   
  end   
   
   # GET method for editing a organisation based on id   
  def edit   
    @organisation = Shift.find(params[:id])   
  end   
   
  # PUT method for updating in database a organisation based on id   
  def update   
    @organisation = Shift.find(params[:id])   
    if @organisation.update_attributes(organisation_params)   
      flash[:notice] = 'Shift updated!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit shift!'   
      render :edit   
    end   
  end   
   
  # DELETE method for deleting a organisation from database based on id   
  def destroy   
    @organisation = Shift.find(params[:id])   
    if @organisation.delete   
      flash[:notice] = 'Shift deleted!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to delete this shift!'   
      render :destroy   
    end   
  end   
   
  # we used strong parameters for the validation of params   
  def shift   
    params.require(:shift).permit(:user_id, :start, :finish, :break_length)   
  end  
end
