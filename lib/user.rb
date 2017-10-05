class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  def display_saved_events
    count = 1
    events.each do |event|
      puts "#{count}. #{event.name} (#{event.date})"
      count += 1
    end
  end

  def delete_saved_event(response)
    event = Event.where("name like ?", "%#{response.upcase}%").first
    self.events.find(event.id).destroy
  end

  def save_event_to_list(response)
    event = Event.where("name like ?", "%#{response.upcase}%").first
    self.events << event
  end

end
