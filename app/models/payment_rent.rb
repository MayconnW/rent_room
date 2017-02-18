class PaymentRent < ActiveRecord::Base
  belongs_to :rent
  
  def pay(rent_id, month, value)
    message = validate_rent(rent_id, month, value)
    raise message if message != ""
    
    result = PaymentRent.create([:rent_id => rent_id, :month => month, :value => value])
    
    return result
    
  end
  
   private
    def validate_rent(rent_id, month, value)
      
      return "Invalid rent" if !Rent.exists?(id: rent_id, status: 1)
      
      pays = PaymentRent.where(:rent_id => rent_id, :month => month)
      amount = 0
      pays.each do |row|
        amount += row.value
      end
      price_room = Rent.find_by(rent_id).room.price_month
      return "Payment has aleady been mande" if amount >= price_room
      
      return "Invalid value" if value <= 0
      
      return ""
    end
  
end
