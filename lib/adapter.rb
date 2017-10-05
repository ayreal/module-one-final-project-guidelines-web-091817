class Adapter

  ROUTE = "https://www.eventbriteapi.com/v3/events/search/?q="
  ZIP_ROUTE = "https://us-zipcode.api.smartystreets.com/lookup?auth-id=9601c401-1372-40a9-b5da-ca55c0e4b510&auth-token=BssThGOWpLWLUD3J4jwA&zipcode="

  def self.get_route
    ROUTE
  end

  def self.get_location_hash_from_zipcode(user_zipcode)
    route = "#{ZIP_ROUTE}#{user_zipcode}"
    response = RestClient.get(route)
    JSON.parse(response)[0]
  end

  def self.get_events_hash(user_keyword, user_zipcode)
    route = "#{ROUTE}#{user_keyword}&sort_by=best&location.address=#{user_zipcode}&location.within=4mi&price=free&start_date.keyword=this_week&token=5WKCC44KCNXWDUR6TWQK"
    response = RestClient.get(route)
    JSON.parse(response)["events"]
  end



end

# a = Adapter.import("beer", "11221")
