class CLI
  def welcome
    puts "\n
           `                                          /`    /:
          `-           ``             `...-.-..--....```   .:m-
                       .:`     ..     -.``/-.```:-```....-yhdMm          `
      ./`   `/+-../o:          .` `:..-:-....:`  .       `odoMN . `      -o.
             .od:+mNm. `       ` ..:--.`..:```            `oMMMyso+       ``
              `+ymN:.``/.      `-````.-`                   -mMMMso:+.  ``
 ``            `-dm- `   `/.   -.   ````    `..             hMMMmys-:` `:
 -s-            `yNm/     ```` `...`./:/`  `:`:`  `-`.-:.`..hMMMMmys:`       -`
 ```             -NNN+     -:` ``.+s//:-`  .:..``-//.`-+-.``hMMMdo/--.       ``
                  oMMN+     ` .odNNMNhs-....:::::::-.:--`   sMMM/````  `-`
   `-/yhmmo//`    `mMMN:     `yMMMMMMMMh     ``````..`` `/:`.MMMy     `hhhy/-` .
  -mNMMMMMMMMy.    /NMMm`    /MMMMMMMMMN.  `    ..     `oNNd+mMMy    `/MMMMMNmho
  sNMMMMMMMMMMo    `hMMMo    :MMMMMMMMMMo `::    `   `:dNMMMMNMMh`  `oNMMMMMMMMM
  sMMMMMMMMMMN-     +MMMd    `MMMMMMMMMNo   `  -`   :hNMMMMNo+MMNo:ymNMMMMMMMMMM
 -mMMMMMMMMMMMo    -mMMm:    `mMMMMMMMMd`     `+`:+sNMMMMMd/``dMMm`hMMMMMMMMMMMM
 `odNMMMMMMMMM/   /NMMN: `:`  -hNMMMMMM/   .::.-+NMMMMMMMy.`  /MMM+hMMMMMMMMMMMM
`  .-osdMMMMMm`  -mMMN/ `.-..`/s-yNMMMM+o/smNNmmNMMMMMMd/`.`  `hMMNNNMMMmNMMMMMM
    -`./NMMMh-.+ymMMMdoo/mmmmdhM:.hMNmNNNMMMMMMMMMMMMNy-  -`   .mNNmoMMMmNMMMMMM
    .```mMMMmshNNMMMMMMMNMMMMMNMNsyd+.-:dMMMMMMMMMMh/:` `       /NNmdmNNMhsdNNh/
    `./oNMMMNmyymNMMMMMMMMMMMNmmNMm/`   /MMMMMMMMm+.` ``/`     `/hhyyyhhhho+/-``
  `oydmdhhmMMMNyymmhmMMMMMMMNhssyNMNo`  `mMMMMMMM/  `:``.      -yyyyyyyyyyyyy+-.
 `smNNNNmdydNMMmsdm+.:osymMMMNdhdNMMNs`  yMMMMMMMh   `    `    -yyyyyyyyyyyyyyyy
 +NNNNNNNNmhymMNyhNm:    .dMMMMMMMMMMMy` oMMMMMMMM`       :-   `syyyyyyhdmhyyyyy
.dNNNNNNNNNNdydNhyNmd:   `-dMMMMMMMMMMMy`oMMMMMMMM`       ``  .+yyyyyyydMMNhosyy
hMMMmdNNNNNNNmyyyhNNm/   ``.dMMMMMMMMMMNooMMMMMMMM`         .+syyyyyyyydMMMd+:yy
MMMN/.hNNNNNNNmssdNm+`      /MMMMMMMMMMMMmMMMMMMMM`      .-`:yyyyyyyyyyhNMNy+.sy
MMm:  .hNNNNNNNddmNs`       `hmMMMMMMMMMMMMMMMMMMd``-.--./m:`syyyyyyyyy+mMMs `.:
Md-    .mNNNNNNNNmy`         `+MMMMMMMMMMMMMMMMMM+``yhddddNmohdhhhhhhh+.mMMs
d:      sNNNNNNNNm.     ``    yMMMMMMMMMMMMMMMMMMd:/smNMMMMMMMMMMNNNNNmmNMMs
`      `-hmNNNNNNN/     ..    +MMMMMMMMMMMMMMMMMMMm:--:osyoooddmmmNNmNNMMMNo
       `odmNNNNNNNh`          hMMMMMMMMMMMMMMMMMMMM/`...`   `yyyyyys.-:+oo/`
      .hNNNNNNNNNNNo         .MMMMMMMMMMMMMMMMMMMMM+        `yyyyyys.           \n".magenta
    puts puts "\n\n                        W   E   L   C   O   M   E  ! \n                        - - - - - - - - - - - - - -\n\n\nFind the best free events this week near you!".blue
    get_user_name
  end

  def get_user_name
    puts "\nWhat is your name?\n".blue
    response = gets.chomp
    @user = User.find_or_create_by(name: response)  #WE HAVE MULTIPLE USERS NOW -- user_location_table?
    get_user_selection
  end

  def get_user_selection
    puts "\nOkay #{@user.name}, what would you like to do next?\n".blue
    puts " 1. Find New Events\n____________________\n\n 2. View Your Events\n____________________\n\n 3. Exit\n".blue
    response = gets.chomp
    case response
    when "1"
      get_user_location
    when "2"
      manage_events
    when "3"
      goodbye
    when "exit".downcase == "exit"
      goodbye
    else
      puts "That option is not valid".blue
      get_user_selection
    end
  end

  def get_user_location
    puts "\nPlease enter a 5-digit zipcode:".blue  # fragile -- certain zips have different data
    response = gets.chomp
      if response.length == 5 && response.to_i != 0
        @location = Location.find_or_create_by(zipcode: response)
        @location.get_name_from_zipcode(response) if @location.name == nil
        get_user_interest(@location)
      else
        puts "\nThat is not a valid zipcode".blue
        get_user_location
      end
  end

  def get_user_interest(location)
    puts "\n\n\nGreat! Let's find free events this week near #{location.name}!\n".blue
    puts "Please enter a keyword for the type of event you're looking for:".blue
    response = gets.chomp
    events = Event.generate_events(response, location)
    display_events(events, response, location)
  end

  def display_events(events, response, location)
    puts puts "\n\n\nHere are some #{response} events this week near #{location.name}:\n".yellow
    puts "===========================================================================
".magenta
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
      ## move this into the User class
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

  def display_saved_events
    puts " "
    puts " My Saved Events This Weekend:"
    @user.display_saved_events
    get_user_selection
  end

  def delete_saved_event
    puts " "
    @user.display_saved_events
    puts "\nWrite the name of the event you'd like to remove or type 'go back'"
    response = gets.chomp
    case response
    when "exit".downcase == "exit"
      goodbye
    when "go back".downcase == "go back"
      binding.pry    #TYPING GO BACK HERE MAKES IT CRASH?
      get_user_selection
    else
      @user.delete_saved_event(response)
    end
    delete_success_message
  end

  def goodbye
    puts "\nCome back anytime to view and maintain your list of events!"
    puts "\n\n                          G   O   O   D   B   Y   E\n                           - - - - - - - - - - - -\n\n\n                     ``
                   ``  ``
                  `       `
                `/`        +:`
              `:syo`      /sss/.
            `:oyyyyo`    .ssssso-``
          `` .-/+syyo`   oss+-`    ```
        `-`       `-::  -:.           ```
      .:/+-                           ``````
   `./++++/                           ````   ```
 `    .:/++-                         ``         ss+-`
         .:/`                                   yddddh:````
                                                yddds.    `/::-..`
                                                ydy-       /++++:`   :++//::````
                                                o-         :++/-     `syyyy/
                                                           -+:`       :yyy/
                                                           .-          oy/
                                                                       ./       \n".blue
    exit
  end

end
