class Rent < ActiveRecord::Base
  belongs_to :room
  belongs_to :client
  
  def rent_room(room_id, client_id, day_payment)
    
    message = validate_rent(room_id, client_id)
    raise message if message != ""
    
    rent = Rent.create([:room_id => room_id, :client_id => client_id, 
                        :day_payment => day_payment, :status => 1])
    
    
    return rent
  end
  
  def free_room(room_id)
    message = validate_free_room(room_id)
    raise message if message != ""
    
    rent = Rent.find_by(room_id:1, status:1)
    rent.status = 0
    rent.save!
    return rent
    
  end
  
  private
    def validate_rent(room_id, client_id)
      
      return "Invalid room" if !Room.exists?(room_id)
      return "Invalid client" if !Client.exists?(client_id)
      return "Room already rented" if Rent.exists?(room_id: room_id, status: 1)
      
      return ""
    end
    
    def validate_free_room(room_id)
      return "Invalid room" if !Room.exists?(room_id)
      return "Room not rented" if !Rent.exists?(room_id: room_id, status: 1)
      return ""
    end


end
