class Rent < ActiveRecord::Base
  belongs_to :room
  belongs_to :client
end
