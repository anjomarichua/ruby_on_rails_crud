module Users   
  class UsersAPI < Grape::API   
   
    format :json   
   
    desc "User List", {   
        :notes => <<-NOTE
        Get All Users   
         __________________   
        NOTE
    }   
   
    get do   
      User.all   
    end   
   
   
    desc "User By Id", {   
        :notes => <<-NOTE   
        Get User By Id   
         __________________   
        NOTE
    }   
   
    params do   
      requires :id, type: Integer, desc: "User id"   
    end   
   
    get ':id' do   
      begin   
        user = User.find(params[:id])   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :not_found }, 404)   
      end   
    end   
   
    desc "Delete User By Id", {   
        :notes => <<-NOTE   
        Delete User By Id   
         __________________   
        NOTE
    }   
   
    params do   
      requires :id, type: Integer, desc: "User id"   
    end   
   
    delete ':id' do   
      begin   
        user = User.find(params[:id])   
        { status: :success } if user.delete   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :error, message: :not_found }, 404)   
      end   
    end   
   
    desc "Update User By Id", {   
        :notes => <<-NOTE   
        Update User By Id   
        __________________   
        NOTE
    }   
   
    params do   
      requires :id, type: Integer, desc: "User id"   
      requires :name, type: String, desc: "User name"
      optional :organisation_id, type: Integer, desc: "User organisation"      
      requires :email, type: String, desc: "User email"    
    end   
   
    put ':id' do   
      begin   
        user = User.find(params[:id])   
        if user.update({   
                              name: params[:name],   
                              price: params[:price],   
                              organisation_id: params[:organisation_id],   
                              email: params[:email],   
                                
                          })   
          { status: :success }   
        else   
          error!({ status: :error, message: user.errors.full_messages.first }) if user.errors.any?   
        end   
   
   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :error, message: :not_found }, 404)   
      end   
    end   
   
   
    desc "Create User", {   
        :notes => <<-NOTE   
        Create User   
        __________________   
        NOTE
    }   
   
    params do   
      requires :name, type: String, desc: "User name"   
      requires :email, type: String, desc: "User email"   
      optional :organisation_id, type: Integer, desc: "User organisation"   
      requires :password_hash, type: String, desc: "Password hash"   
      requires :password_salt, type: String, desc: "Password sall" 
      
    end   
   
    post do   
      begin   
        user =  User.create({   
                                      name: params[:name],   
                                      price: params[:price],   
                                      email: params[:email],  
		                              organisation_id: params[:organisation_id],   
		                              password_hash: params[:password_hash],  
		                              password_salt: params[:password_salt] 
                                        
                                  })   
        if user.save   
          { status: :success }   
        else   
          error!({ status: :error, message: user.errors.full_messages.first }) if user.errors.any?   
        end   
   
   
      rescue ActiveRecord::RecordNotFound   
        error!({ status: :error, message: :not_found }, 404)   
      end
    end
  end
end