class PaymentSecure < ActiveRecord::Base
  belongs_to :rent
  
  def pay(rent_id, value)
    message = validate_rent(rent_id, value)
    raise message if message != ""
    
    result = PaymentSecure.create([:rent_id => rent_id, :value => value])
    
    return result
    
  end
  
   private
    def validate_rent(rent_id, value)
      
      return "Invalid rent" if !Rent.exists?(id: rent_id, status: 1)
      
      pays = PaymentSecure.where(:rent_id => rent_id)
      amount = 0
      pays.each do |row|
        amount += row.value
      end
      price_secure = Rent.find_by(rent_id).room.price_secure
      return "Payment has aleady been mande" if amount >= price_secure
      
      return "Invalid value" if value <= 0
      
      return ""
    end
  
end
