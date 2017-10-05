class Event < ActiveRecord::Base
  belongs_to :location

  def self.generate_events(user_keyword, location_obj)
    # CLEAN UP CODE
    json_events_ary = Adapter.get_events_hash(user_keyword, location_obj.name)
    json_events_ary = json_events_ary[0..4]
    events = []
    events_hash = json_events_ary.map do |event_hash|
      name = event_hash["name"]["text"].upcase
      date = event_hash["start"]["local"].slice(0,10)
      description = event_hash["description"]["text"]
      e = Event.find_or_create_by(name: name, location_id: location_obj.id, date: date, description: description)
      e.keyword = user_keyword
      events << e
    end
    events
  end

  def self.display_events(events)
    #keyword is a string, user_zipcode is a location obj


    count = 1
    id = 0
    events.map do |event|
      # Print out the results to the user
      puts "#{count}. #{event.name} :
      (#{event.date}) #{event.description.slice(0,130).gsub("\n", ' ').squeeze(' ')} ..."
      puts " "
      id = event.id
      count += 1
        # break if count > 5
    end
  end

end
