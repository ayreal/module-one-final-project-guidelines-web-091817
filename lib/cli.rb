class CLI
  def welcome
    puts "Welcome! Find the best free events this week near you!"
    get_user_name
  end

  def get_user_name
    puts "What is your name?"
    response = gets.chomp
    @user = User.find_or_create_by(name: response)  #WE HAVE MULTIPLE USERS NOW -- user_location_table?
    get_user_selection
  end

  def get_user_selection

    puts "Okay #{@user.name}, what would you like to do next?"
    puts "1. Find New Events 2. View Your Events 3. Exit"
    response = gets.chomp
    case response
    when "1"
      get_user_location
    when "2"
      display_saved_events
    when "3"
      goodbye
    when "exit".downcase == "exit"
      goodbye
    else
      puts "That option is not valid"
      get_user_selection
    end
  end

  def get_user_location
    puts "Please enter a 5-digit zipcode:"  # fragile -- certain zips have different data
    response = gets.chomp
      if response.length == 5 && response.to_i != 0
        @location = Location.find_or_create_by(zipcode: response)
        @location.get_name_from_zipcode(response) if @location.name == nil
        get_user_interest(@location)
      else
        puts "That is not a valid zipcode"
        get_user_location
      end
  end

  def get_user_interest(location)
    puts "Great! Let's find free events this week near #{location.name}!"
    puts "Please enter a keyword for the type of event you're looking for:"
    response = gets.chomp
    events = Event.generate_events(response, location)
    display_events(events, response, location)
  end

  def display_events(events, response, location)
    puts "Here are some #{response} events this week near #{location.name}:"
    Event.display_events(events)  # this method puts out event choices, check to see if there are any
    user_save_options
  end

  def user_save_options
    puts "Would you like to save any of these events to your list of favorites?"
    puts "Type the name of the event you want to save, type 'new events', or type 'exit'"
    response = gets.chomp
    case response
    when "new events"
      # persist this data to the DB
      get_user_location
    when "exit"
      goodbye
    else
      event = Event.find_by_name(response.upcase)
      @user.events << event
      save_success_message
    end
  end

  def save_success_message
    count = @user.events.count
    puts "You have saved this event to your favorites."
    puts "You now have #{count} event(s) saved."
    get_user_selection
  end

  def display_saved_events
    @user.display_saved_events
    get_user_selection
  end

  def goodbye
    puts "Enjoy your week!"
    exit
  end

#
# find events
# User action: select interest (5 options)
#
# Show a list of the free events
#
# User action: find new events, save event, view saved events, exit
#
# save event to favorites
#
# view saved events
#
# delete event from favorites
#
# Exit message
end
