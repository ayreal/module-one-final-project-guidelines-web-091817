class CLI
  def welcome
    puts "Welcome! Find the best free events this week near you!"
    get_user_name
  end

  def get_user_name
    puts "\nWhat is your name?"
    response = gets.chomp
    @user = User.find_or_create_by(name: response)  #WE HAVE MULTIPLE USERS NOW -- user_location_table?
    get_user_selection
  end

  def get_user_selection
    #
    puts "\nOkay #{@user.name}, what would you like to do next?"
    puts "1. Find New Events 2. Manage My Events 3. Exit"
    response = gets.chomp
    case response
    when "1"
      get_user_location
    when "2"
      @user.has_events? ? manage_events : no_events_message
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
    #
    puts "\nPlease enter a 5-digit zipcode:"
    response = gets.chomp
      if response.length == 5 && response.to_i != 0
        @location = Location.find_or_create_by(zipcode: response)
        @location.get_name_from_zipcode(response) if @location.name == nil
        get_user_interest(@location)
      else
        puts "\nThat is not a valid zipcode"
        get_user_location
      end
  end

  def get_user_interest(location)
    puts "\nGreat! Let's find free events this week near #{location.name}!"
    puts "Please enter a keyword for the type of event you're looking for:"
    response = gets.chomp
    events = Event.generate_events(response, location)
    display_events(events, response, location)
  end

  def no_events_message
    puts "You don't have any events yet!"
    get_user_selection
  end

  def display_events(events, response, location)
    puts "\nHere are some #{response} events this week near #{location.name}:"
    if events.count != 0
      Event.display_events(events)  # this method puts out event choices, check to see if there are any
      user_save_options
    else
      puts "Hmm...looks like there are no recommended free #{response} events near #{location.name} this week."
      puts "Try a different keyword or search in a different city!"
      get_user_selection
    end
  end

  def user_save_options
    puts "\nWould you like to save any of these events to your list of favorites?"
    puts "Type the name of the event you want to save, type 'new events' type 'view events' or type 'exit'"
    response = gets.chomp
    case response
    when "new events"
      get_user_location
    when "view events"
      manage_events
    when "exit"
      goodbye
    else
      @user.save_event_to_list(response)
      save_success_message
    end
  end

  def count
    count = @user.events.count
    puts "You now have #{count} event(s) saved."
  end

  def save_success_message
    puts "\nYou have saved this event to your favorites."
    count
    get_user_selection
  end

  def delete_success_message
    puts "\nYou have deleted this event from your favorites."
    count
    get_user_selection
  end

  def manage_events
    puts " "
    puts "My Saved Events This Week:"
    @user.display_saved_events
    puts "\nSelect a number to continue."
    puts "1. Delete A Saved Event 2. Find New Events 3. Exit"
    response = gets.chomp
    case response
    when "1"
      delete_saved_event
    when "2"
      get_user_selection
    when "3"
      goodbye
    when "exit".downcase == "exit"
      goodbye
    else
      puts "That option is not valid"
      get_user_selection
    end
  end

  def delete_saved_event   #this is buggy, cant' type exit or go back, events not deleting?
    puts " "
    @user.display_saved_events
    puts "\nWrite the name of the event you'd like to remove or type 'go back'"
    response = gets.chomp
    case response
    when "exit".downcase == "exit"
      goodbye
    when "go back".downcase == "go back"
      get_user_selection
    else
      @user.delete_saved_event(response)
      delete_success_message
    end
  end

  def goodbye
    puts "\nCome back anytime to view and maintain your list of events!"
    puts "Enjoy your week!"
    exit
  end

end
