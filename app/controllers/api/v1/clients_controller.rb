class Api::V1::ClientsController < Api::V1::DefaultApiController
  
  def index
    data = Client.list
    message = ""
    status = "success"
    _response(status, data, message)
  end
  
end
