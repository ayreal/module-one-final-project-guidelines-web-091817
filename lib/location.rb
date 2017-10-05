class Location < ActiveRecord::Base
  belongs_to :user
  has_many :events

  def get_name_from_zipcode(user_zipcode) #zipcode is a string from CLI user input
    location = Adapter.get_location_hash_from_zipcode(user_zipcode)
    state = location["city_states"][0]["state_abbreviation"]
    city = location["city_states"][0]["city"]
    self.name = city
  end
end
