require 'bcrypt'
require 'securerandom'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include BCrypt
         
  belongs_to :role
  before_create :set_default_role
  
  #scope :my_user, -> { where(id: @userteste.id) }
  
  validates :url, uniqueness: true, presence: true
  
  has_attached_file :photo,
    :styles => {
      :thumb => "100x100#",
      :small  => "150x150>",
      :medium => "200x200" 
    }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method: 
  attr_accessor :delete_photo
  before_validation { self.photo.clear if self.delete_photo == '1' }
  
  #Se quiser alterar o campo de visualização pode se usar o comando
  #config.label_methods.unshift(:display_name)
  #em seguida criar a função com o nome sugerido
  
  def login_api(email, pass)
    user = User.find_by_email(email)
    if (user) and (user.valid_password?pass)
      
      UserApi.delete_all "user_id = #{user.id}"
      
      user_api = UserApi.new
      user_api.user = user
      user_api.token = generate_token pass
      user_api.save
      return user_api
    else
      raise "Invalid user or password"
    end
  end
  
  private
  def set_default_role
    self.role ||= Role.find_by_name('admin')
  end
  
  def generate_token(pass)
    random_string = SecureRandom.hex
    salt = BCrypt::Engine.generate_salt
    result = BCrypt::Engine.hash_secret(pass,salt,random_string)
    return result
  end
  
  #scopes [:my_user]
  
  RailsAdmin.config do |config|
    config.model 'User' do
      list do
        field :id
        field :name
        field :email
      end
      edit do
        field :email
        field :password
        field :password_confirmation
        field :role
        field :url
        field :name
        field :photo
      end
    end
  end
  
end
