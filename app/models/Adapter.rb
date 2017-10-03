
require 'rest-client'
require 'json'
require 'pry'

class Adapter

  def get_free_events_hash(date_keyword) # a string value
    url = "URL"
    hash = JSON.parse(RestClient.get(url))

  
  end

end
