class Event < ActiveRecord::Base
  belongs_to :location

  def self.find_events_hash(user_keyword, user_zipcode)
    events_hash = Adapter.get_events_hash(user_keyword, user_zipcode.name)
    cat = events_hash.map do |e|
      events = Event.find_or_initialize_by(e[:name][:text], e[:start][:local], e[:id], e[:description][:text])
    end
    cat
  end


  # def display_events(events_hash)
  #   count = 1
  #   events_hash.collect do |key, value|
  #     puts "#{count}. #{key}: #{value}"
  #     count ++
  #   end
  # end
end
