

class Event < ActiveRecord::Base
  belongs_to :location

  # def parse_data_from_json
  #   parsed_hash = {}
  #   json_events_hash = Adapter.get_events_hash(user_keyword, user_zipcode.name)
  #   binding.pry
  #   json_events_hash
  #
  # end

  def self.display_events(user_keyword, user_zipcode)

    json_events_ary = Adapter.get_events_hash(user_keyword, user_zipcode.name)
    count = 1
    json_events_ary.each do |event_hash|
      # event_hash
      name = event_hash["name"]["text"].upcase
      location = event_hash["end"]["timezone"].upcase
      date = event_hash["start"]["local"].slice(0,10)
      description = event_hash["description"]["text"]
      self.find_or_create_by(name: name, location_id: user_zipcode.id, date: date, description: description)
      end
      # puts "#{count}. #{event_hash["name"]["text"]}"
      # puts " "
      # puts "#{event_hash["description"]["text"].slice(0,120)} ..."
      # puts " "
      # count += 1
      #

  end

  # def self.find_events_hash(user_keyword, user_zipcode)  #user_zipcode = a location obj
  #   json_events_ary = Adapter.get_events_hash(user_keyword, user_zipcode.name)
  #     # this is an array of hashes
  #   json_events_ary.collect do |event_hash|
  #     binding.pry
  #     parsed_hash = {id: nil, name: nil, location_id: nil, date: nil, description: nil}
  #     parsed_hash[:name] = event_hash["name"]["text"]
  #     parsed_hash[:date] = event_hash["start"]["local"]
  #     parsed_hash[:description] = event_hash["description"]["text"]
  #   end
  #
  # end





  # def self.find_events_hash(user_keyword, user_zipcode)
  #   events_hash = Adapter.get_events_hash(user_keyword, user_zipcode.name)
  #
  #   events_hash.map do |e|
  #     binding.pry
  #     self.find_or_initialize_by(e["name"]["text"], e["start"]["local"], e["id"], e["description"]["text"])
  #   end
  # end


  # def display_events(events_hash)
  #   count = 1
  #   events_hash.collect do |key, value|
  #     puts "#{count}. #{key}: #{value}"
  #     count ++
  #   end
  # end
end
