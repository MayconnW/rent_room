class Hotel < ActiveRecord::Base
  
  has_attached_file :photo,
    :styles => {
      :thumb => "100x100#",
      :small  => "150x150>",
      :medium => "200x200" 
    },
    :default_url => '/defaults/photos/hotel.jpg'
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method: 
  attr_accessor :delete_photo
  before_validation { self.photo.clear if self.delete_photo == '1' }
  
  def photo_url
    photo.url
  end
  
  def Hotel.list
    sql = "select h.*, 
                  	(select count(*) 
                       	from rooms r 
                       	left join apartments a on (r.apartment_id = a.id)
                       where a.hotel_id = h.id and r.status = 0)  as free_rooms		
                  from hotels h"
    hotels = Hotel.find_by_sql(sql)
    result = []
    hotels.each do |hotel|
      result.push hotel.fill_object
    end
    return result
  end
  
  def fill_object
    result = {};
    default_columns_json.each do |column|
      result[column.to_sym] = send(column)
    end
    return result
  end
  
  def default_columns_json  
    return ["id", "description", "address", "cep", "free_rooms", 
             "photo_url", "created_at", "updated_at"
    ]
  end
  
end
