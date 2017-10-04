class Location < ActiveRecord::Migration
  belongs_to :user
  has_many :events
end
