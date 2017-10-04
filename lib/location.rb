class Location < ActiveRecord::Base
  belongs_to :user
  has_many :events
  # def self.name
  #   #get the name of the location from the events table
  #   event = Event.where("location_id" == self.id)
  #   event.name
  # end
end
