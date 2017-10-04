# Welcome message
class CLI

  def welcome
    puts "Welcome! Find the best free events this week near you!"
    get_user_name
  end

  def get_user_name
    puts "What is your name?"
    response = gets.chomp
    @user = User.new(response)
    get_user_selection
  end

  def get_user_selection
    puts "Okay #{@user.name}, what would you like to do?"
    puts "1. Find New Events 2. View Saved Events 3. Exit"
    response = gets.chomp
    case response
    when "1"
      get_user_zipcode
    when "2"
      display_saved_events
    when "3"
      goodbye
    else
      puts "That option is not valid"
      get_user_selection
    end
  end

  def get_user_zipcode
    puts "Please enter a zipcode:"
    response = gets.chomp
    @user.zipcode = response
    user_event_choices
  end

  def user_event_choices
    puts "Here are some free event categories this week near #{@user.zipcode}:"
    puts "Please make a selection from the following:"
    puts "1. Dance 2. Beer 3. Music 4. Exit"
    response = gets.chomp
    case response
    when "1"
      display_dance_events
    when "2"
      display_beer_events
    when "3"
      display_music_events
    when "exit"
      exit
    else
      puts "That option is not valid"
      user_event_choices
    end
  end

  def display_dance_events
    dance_hash = Adapter.get_dance_events(@user.zipcode)
    # parse the events
    #display options
    puts "1. #{event1.name}"
    puts "2. #{event2.name}"
    puts "3. #{event3.name}"
    puts "4. #{event4.name}"
    puts "5. #{event5.name}"
    user_save_options
  end

  def display_beer_events
    binding.pry
  end

  def display_saved_events

  end

  def user_save_options
    puts "Select an event number to save (1-5), type 'new events', or type 'exit'"
    response = gets.chomp
    case response
    when "1"
      # persist this data to the DB
      save_success_message
    when "2"

    when "3"

    when "4"

    when "5"

    when "new events"
      user_event_choices
    when "exit"
      goodbye
    else
      puts "That option is not valid"
      user_save_options
    end
  end

  def save_success_message
    puts "You have saved this event to your favorites"
    get_user_selection
  end

  def display_saved_events
    #@user.saved_events

  end

  def method_name

  end

  def goodbye
    puts "Goodbye"
    exit
  end


# find events
# User action: select interest (5 options)

# Show a list of the free events

# User action: find new events, save event, view saved events, exit

# save event to favorites

# view saved events

# delete event from favorites

# Exit message
end
