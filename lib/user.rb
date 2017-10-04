class User < ActiveRecord::Migration
# has_many :locations
# has_many :events, through: :locations
#

### to test out inputs
attr_accessor :name, :zipcode
  def initialize(name)
    @name = name
    @zipcode = zipcode
  end
end
