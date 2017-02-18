class UserDefaultController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    
    if !current_user
      redirect_to :new_user_session_path
    elsif current_user.role.name == 'admin'
      redirect_to "/admin"  
    elsif current_user.role.name != 'user'
      redirect_to :new_user_session_path unless current_user && current_user.role.name == 'user'
    end
  end
end
