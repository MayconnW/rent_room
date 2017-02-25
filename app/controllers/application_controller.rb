class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  
  def _response(status, data, message)
    respond_to do |format|
      msg = { :status => status, :data => data, :message => message }
      format.json  { render :json => msg }
    end
  end
  
end
