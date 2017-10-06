class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  def display_saved_events
    count = 1
    self.events.each do |event|
      # binding.pry
      puts "#{count}. #{event.name} (#{event.date})"
      count += 1
    end
  end

  def delete_saved_event(response)
    # check if the response is in the saved events
    response = response.upcase
    event = Event.where("name like ?", "%#{response}%").first
    binding.pry
    # self.events.find(event.id).destroy
    event.delete
  end

  def save_event_to_list(response)
    response = response.upcase
    event = Event.where("name like ?", "%#{response}%").first
    self.events << event
  end

  def has_events?
    self.events != []
  end

end
