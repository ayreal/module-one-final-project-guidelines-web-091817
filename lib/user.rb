class User < ActiveRecord::Base
  has_many :locations
  has_many :events, through: :locations

### to test out inputs

end
