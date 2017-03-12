class Apartment < ActiveRecord::Base
  belongs_to :hotel
  
  has_attached_file :photo,
    :styles => {
      :thumb => "100x100#",
      :small  => "150x150>",
      :medium => "200x200" 
    },
    :default_url => '/defaults/photos/apartment.jpg'
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method: 
  attr_accessor :delete_photo
  before_validation { self.photo.clear if self.delete_photo == '1' }
  
  def photo_url
    photo.url
  end
  
  def Apartment.list_of_apartments(hotel_id)
    apartments = Apartment.where hotel_id: hotel_id
    result = []
    apartments.each do |ap|
      result.push ap.fill_object
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
    return ["id", "description", "number", "hotel_id",
            "photo_url", "created_at", "updated_at"
    ]
  end
end
