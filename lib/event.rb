class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, through: :user_events

  def self.generate_events(user_keyword, location_obj)
    # CLEAN UP CODE
    json_events_ary = Adapter.get_events_hash(user_keyword, location_obj.name)
    json_events_ary = json_events_ary[0..4] if json_events_ary.count > 5
    events = []
    events_hash = json_events_ary.map do |event_hash|
      name = event_hash["name"]["text"].upcase
      date = event_hash["start"]["local"].slice(0,10)
      description = event_hash["description"]["text"]
      e = Event.find_or_create_by(name: name, date: date, description: description)
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
      (#{event.date}) #{event.description.slice(0,160).gsub("\n", ' ').squeeze(' ')} ..."
      puts " "
      id = event.id
      count += 1
        # break if count > 5
    end
  end



end
