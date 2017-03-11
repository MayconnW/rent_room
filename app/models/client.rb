class Client < ActiveRecord::Base
  
  has_attached_file :photo,
    :styles => {
      :thumb => "100x100#",
      :small  => "150x150>",
      :medium => "200x200" 
    },
    :default_url => '/defaults/photos/client.png'
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method: 
  attr_accessor :delete_photo
  before_validation { self.photo.clear if self.delete_photo == '1' }
  
  def photo_url
    photo.url
  end
  
  def Client.list
    clients = Client.all
    result = []
    clients.each do |client|
      result.push client.fill_object
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
    return [
            "id", "first_name", "last_name", "born", "country",
            "phone", "created_at", "updated_at", "photo_url"
    ]
  end
  
end
