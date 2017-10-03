
require 'rest-client'
require 'json'
require 'pry'

class Adapter
  attr_accessor :path

  ROUTE = "https://www.eventbriteapi.com/v3/events/search/?q="

  def self.get_route
    ROUTE
  end

  def get_nearby_events_this_week
    "&sort_by=best&location.within=4mi&location.latitude=40.705215&location.longitude=-74.014252&price=free&start_date.keyword=this_week&token=5WKCC44KCNXWDUR6TWQK"
  end

  def get_events_ary  #beer will be replaced by a user input
    JSON.parse(RestClient.get("#{ROUTE}#{"dance"}#{self.get_nearby_events_this_week}"))["events"]
  end

#   def get_events_hashes
#     self.get_events_ary.collect {|ary| ary}
#   end
# end


a1 = Adapter.new
a1.get_events_hashes
# Pry.start
