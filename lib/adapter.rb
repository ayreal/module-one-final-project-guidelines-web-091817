class Adapter

  ROUTE = "https://www.eventbriteapi.com/v3/events/search/?q="

  def self.get_route
    ROUTE
  end

  def self.get_events_hash(user_keyword, user_zipcode)
    route = "#{ROUTE}#{user_keyword}&sort_by=best&location.address=#{user_zipcode}&location.within=4mi&price=free&start_date.keyword=this_week&token=5WKCC44KCNXWDUR6TWQK"
    response = RestClient.get(route)
    JSON.parse(response)["events"]
  end

end

# a = Adapter.import("beer", "11221")
