module Organisations
  class OrganisationsAPI < Grape::API   
   
    format :json   
   
    desc "Organisation List", {   
        :notes => <<-NOTE
        Get All Organisations   
         __________________   
        NOTE
    }   
   
    get do   
      Organisation.all   
    end   
   
   
    desc "Organisation By Id", {   
        :notes => <<-NOTE   
        Get Organisation By Id   
         __________________   
        NOTE
    }   
   
    params do   
      requires :id, type: Integer, desc: "Organisation id"   
    end   
   
    get ':id' do   
      begin   
        orgranisation = Organisation.find(params[:id])   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :not_found }, 404)   
      end   
    end   
   
    desc "Delete Organisation By Id", {   
        :notes => <<-NOTE   
        Delete Organisation By Id   
         __________________   
        NOTE
    }   
   
    params do   
      requires :id, type: Integer, desc: "Organisation id"   
    end   
   
    delete ':id' do   
      begin   
        orgranisation = Organisation.find(params[:id])   
        { status: :success } if orgranisation.delete   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :error, message: :not_found }, 404)   
      end   
    end   
   
    desc "Update Organisation By Id", {   
        :notes => <<-NOTE   
        Update Organisation By Id   
        __________________   
        NOTE
    }   
   
    params do   
      requires :id, type: Integer, desc: "Organisation id"   
      optional :name, type: String, desc: "Organisation name"
      requires :hourly_rate, type: Float, desc: "Organisation hourly_rate"      
    end   
   
    put ':id' do   
      begin   
        orgranisation = Organisation.find(params[:id])   
        if orgranisation.update({   
                              name: params[:name],   
                              hourly_rate: params[:hourly_rate],   
                                
                          })   
          { status: :success }   
        else   
          error!({ status: :error, message: orgranisation.errors.full_messages.first }) if orgranisation.errors.any?   
        end   
   
   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :error, message: :not_found }, 404)   
      end   
    end   
   
   
    desc "Create Organisation", {   
        :notes => <<-NOTE   
        Create Organisation   
        __________________   
        NOTE
    }   
   
    params do   
      requires :name, type: String, desc: "Organisation name"
      requires :hourly_rate, type: Float, desc: "Organisation hourly_rate"    
      
    end   
   
    post do   
      begin   
        orgranisation =  Organisation.create({   
                                      name: params[:name],   
 									  hourly_rate: params[:hourly_rate],                                        
                                  })   
        if orgranisation.save   
          { status: :success }   
        else   
          error!({ status: :error, message: orgranisation.errors.full_messages.first }) if orgranisation.errors.any?   
        end   
   
   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :error, message: :not_found }, 404)   
      end
    end
  end
end