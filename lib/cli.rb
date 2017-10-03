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
    #@user.location = response
    user_event_choices
  end

  def user_event_choices
    puts "Here are some free event categories this week near" #{@user.location}:"
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
    ### HERE
    dance_hash = Adapter.get_dance_hash
  end

  def display_beer_events
    binding.pry
  end


  def display_saved_events

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
