class Adapter

  ROUTE = "https://www.eventbriteapi.com/v3/events/search/?q="

  def self.get_route
    ROUTE
  end

  def self.get_events_hash(event_type, location)
    route = "#{ROUTE}#{event_type}&sort_by=best&location.address=#{location}&location.within=4mi&price=free&start_date.keyword=this_week&token=5WKCC44KCNXWDUR6TWQK"
    response = RestClient.get(route)
    JSON.parse(response)["events"]
  end


#  def self.import
#   e = Event.new("name", "area", "time", 8, "descccc")
#   get_events_hash.map do |e|
#     events = Event.new(e[:name][:text], e[:start][:timezone], e[:start][:local], e[:id], e[:description][:text])
#     end
#   end
# end


end
