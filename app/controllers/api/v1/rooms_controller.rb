class Api::V1::RoomsController < Api::V1::DefaultApiController
  respond_to :json
  
  def index
    #data = Room.where(id: 6)
    data = Room.all
    message = ""
    status = "success"
    _response(status, data, message)
  end
  
end
