# Welcome message
class CLI

  def welcome
    puts "Welcome! Find the best free events near you!"
    get_user_name
  end

  def get_user_name
    puts "What is your name?"
    response = gets.chomp
    @user = User.new(response)
  end


# def user_selection
#   puts "Okay #{user[:name]}, please enter your zipcode:"
#   response
# User action:  find new events, save event, view saved events, exit

# find events
# User action: select interest (5 options)

# Show a list of the free events

# User action: find new events, save event, view saved events, exit

# save event to favorites

# view saved events

# delete event from favorites

# Exit message
end
