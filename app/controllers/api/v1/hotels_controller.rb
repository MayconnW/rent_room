class Api::V1::HotelsController < Api::V1::DefaultApiController
  
  def index
    data = Hotel.list
    message = ""
    status = "success"
    _response(status, data, message)
  end
  
  def list_of_apartments
    validate = validate_param_to_list_apartments
    if validate != ""
      data = {}
      message = validate
      status = 'error'
    else
      data = Apartment.list_of_apartments(params[:hotel_id])
      message = ""
      status = "success"
    end
    
    _response(status, data, message)
  end
  
  def list_of_rooms
    validate = validate_param_to_list_rooms
    if validate != ""
      data = {}
      message = validate
      status = 'error'
    else
      room = Room.new
      if params.has_key?(:apartment_id)
        data = room.list_of_rooms_by_apartment(params[:apartment_id])
      else
        data = room.list_of_rooms_by_hotel(params[:hotel_id])
      end
      message = ""
      status = "success"
    end
    
    _response(status, data, message)
  end
  
  private
  def validate_param_to_list_apartments
    return "Please inform the param hotel_id" if !params.has_key?(:hotel_id)
    return  ""
  end
  def validate_param_to_list_rooms
    return "Please inform the param hotel_id or apartment_id" if (!params.has_key?(:hotel_id) && !params.has_key?(:apartment_id))
    return  ""
  end
  
end