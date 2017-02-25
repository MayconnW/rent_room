class Api::V1::RentsController < Api::V1::DefaultApiController
  respond_to :json
  
  def rent_room
    
    validate = validate_param_to_rent
    if validate != ""
      data = {}
      message = validate
      status = 'error'
    else
    
      rent = Rent.new
      
      begin
        data = rent.rent_room params[:room_id], params[:client_id], params[:payment_day]
        message = "Room rented successfully"
        status = "success"
      rescue Exception => e
        data = {}
        message = "#{e.message}"
        status = "error"
      end
    end
    
    _response(status, data, message)
    
  end
  
  def free_room
    validate = validate_param_to_free
    if validate != ""
      data = {}
      message = validate
      status = 'error'
    else
    
      rent = Rent.new
      
      begin
        data = rent.free_room params[:room_id]
        message = "Room successfully released"
        status = "success"
      rescue Exception => e
        data = {}
        message = "#{e.message}"
        status = "error"
      end
    end
    
    _response(status, data, message)
    
  end
  
  def pay_rent
    validate = validate_param_to_pay_rent
    if validate != ""
      data = {}
      message = validate
      status = 'error'
    else
      payment = PaymentRent.new
      
      begin
        data = payment.pay params[:rent_id],  params[:value].to_i, params[:month].to_i, params[:year].to_i
        message = "Payment made successfully"
        status = "success"
      rescue Exception => e
        data = {}
        message = "#{e.message}"
        status = "error"
      end
    end
    
    _response(status, data, message)
    
  end
  
  def pay_secure
    
    validate = validate_param_to_pay_secure
    if validate != ""
      data = {}
      message = validate
      status = 'error'
    else
      payment = PaymentSecure.new
      
      begin
        data = payment.pay params[:rent_id], params[:value].to_i
        message = "Payment made successfully"
        status = "success"
      rescue Exception => e
        data = {}
        message = "#{e.message}"
        status = "error"
      end
    end
    
    _response(status, data, message)
    
  end
  
  private 
    def validate_param_to_rent
      return "Please inform the param room_id" if !params.has_key?(:room_id)
      return "Please inform the param client_id" if !params.has_key?(:client_id)
      return "Please inform the param payment_day" if !params.has_key?(:payment_day)
      return  ""
    end
    def validate_param_to_free
      return "Please inform the param room_id" if !params.has_key?(:room_id)
      return  ""
    end
    def validate_param_to_pay_rent
      return "Please inform the param rent_id" if !params.has_key?(:rent_id)
      return "Please inform the param month" if !params.has_key?(:month)
      return "Please inform the param year" if !params.has_key?(:year)
      return "Please inform the param value" if !params.has_key?(:value)
      return "The param value must be greater than 0" if params[:value].to_i <= 0
      return "The param month must be between 1 and 12" if !(1..12).include?(params[:month].to_i)
      return  ""
    end
    def validate_param_to_pay_secure
      return "Please inform the param rent_id" if !params.has_key?(:rent_id)
      return "Please inform the param value" if !params.has_key?(:value)
      return "The param value must be greater than 0" if params[:value].to_i <= 0
      return  ""
    end
    def room_params
      params.
        require(:room).
        permit(:room_id, :client_id, :payment_day)
    end
end
