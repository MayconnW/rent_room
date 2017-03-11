class Room < ActiveRecord::Base
  belongs_to :apartment
  
   has_attached_file :photo,
    :styles => {
      :thumb => "100x100#",
      :small  => "150x150>",
      :medium => "200x200" 
    },
    :default_url => '/defaults/photos/room.jpg'
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method: 
  attr_accessor :delete_photo
  before_validation { self.photo.clear if self.delete_photo == '1' }
  
  def photo_url
    photo.url
  end
  
  def list_of_rooms_by_hotel(hotel_id)
    sql = "select r.* 
                  from rooms r
                  left join apartments a on (r.apartment_id = a.id)
                  where a.hotel_id = #{hotel_id}"
    rooms = Room.find_by_sql(sql)
    return build(rooms)
  end
  
  def list_of_rooms_by_apartment(apartment_id)
    rooms = Room.where apartment_id: apartment_id
    return build(rooms)
  end
  
  def build(data)
    result = []
    data.each do |row|
      result.push row.fill_object
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
    return ["id", "description", "number", "apartment_id", "price_month", 
            "price_secure", "status", "photo_url", "created_at", "updated_at"
    ]
  end
  
end
