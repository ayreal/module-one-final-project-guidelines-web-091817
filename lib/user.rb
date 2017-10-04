class User < ActiveRecord::Migration

### to test out inputs
attr_accessor :name, :zipcode
  def initialize(name)
    @name = name
    @zipcode = zipcode
  end
end
