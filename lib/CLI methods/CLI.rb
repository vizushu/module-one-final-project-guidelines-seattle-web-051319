class CLI
  attr_accessor :menu, :random_song, :is_running, :preference, :a, :random_artist_song
  @@user_1 = nil

  def initialize
  end

  def self.user_1
    @@user_1
  end

  #This method runs the program and is called upon in our bin/run.rb file to run
  #the application it also displays a welcome message and asks the user to enter
  #a username
  def run
    CLIOutputs.welcome
    get_username_and_count
    main_menu
  end

 #This method gets the username and welcomes either a new or returning user
  def get_username_and_count
    name = STDIN.gets.chomp
    puts
    if User.find_by_name(name) == nil
      @@user_1 = User.create(name: name, count: 1)
      puts "Welcome #{@@user_1.name}."
    else
      @@user_1 = User.find_by_name(name)
      puts "Welcome back #{@@user_1.name}!"
    end
  end

  #This method is our main menu which shows all of our main menu prompts
  def main_menu
    @is_running = true
    while @is_running
      @menu = 1
      if @menu == 1
          CLIOutputs.main_menu
        if @@user_1.count == 1
          puts "1. Let me see a random song"
          puts "2. Let me see a random song by a specific artist"
        else
          puts "1. Let me see #{@@user_1.count} random songs"
          puts "2. Let me see #{@@user_1.count} random songs by a specific artist"
        end
        CLIOutputs.main_menu_options
        first_choice
        end
      end
    end

    #This method takes a users choice in response to the previous methods prompt
    #and takes the appropriate action
    def first_choice
        choice = STDIN.gets.chomp.to_i
      if choice == 1
        random_song(@@user_1.count)
      elsif choice == 2
        random_song_by_artist(@@user_1.count)
      elsif choice == 3
        view_likes_dislikes(1)
      elsif choice == 4
        view_likes_dislikes(2)
      elsif choice == 5
        settings
      elsif choice == 6
        @is_running = false
      end
    end

    #This method displays a random song or songs depending on the amount of songs
    #a user has chosen to be displayed
    def random_song(number_of_songs)
      @random_song = CLIMethods.filter_songs.sample(number_of_songs)
      CLIOutputs.random_song_title
      @random_song.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} by: #{song.artist.name}"
      end
      CLIOutputs.options
      if @@user_1.count == 1
        CLIOutputs.one_random_song_options
      else
        CLIOutputs.multiple_random_song_options
        puts "3. Give me #{@@user_1.count} more random songs"
      end
      puts "4. Main menu"
      puts
      saved_song(1)
    end

    #This method displays a random song or songs by a specific artist after
    #querying the user for a specific artist to find. It also displays an error
    #message if the name provided does not match any songs in the database
    def random_song_by_artist(number_of_songs)
      puts "Please provide an artist name:"
      puts
      artist_name = STDIN.gets.chomp
      all_artist_songs = CLIMethods.filter_songs.select do |song|
        song.artist.name.parameterize == artist_name.parameterize
      end
      @random_artist_song = all_artist_songs.sample(number_of_songs)
      if all_artist_songs.count > 0
        puts "#{@random_artist_song.sample.artist.name}:"
        @random_artist_song.each_with_index do |song, index|
          puts "#{index+1}. #{song.name}"
        end
        CLIOutputs.options
        if @random_artist_song.count == 1
          CLIOutputs.one_random_song_by_artist_options
        else
          CLIOutputs.multiple_random_song_options
          puts "3. Give me #{@@user_1.count} more random songs by an artist"
        end
        puts "4. Main menu"
        puts
        saved_song(2)
      else
        puts "There are no songs by #{artist_name}"
        CLIOutputs.no_likes_dislikes_menu_options
        no_likes_dislikes_menu
      end
    end

    #This method saves a song or songs to a user's likes or dislikes, or gives
    #them another random song based on which option they choose
    def saved_song(argument)
      @menu = 2
      choice = STDIN.gets.chomp.to_i
      if choice == 1
        puts
        if argument == 1
          CLIMethods.saved_like_dislike(@random_song, Like)
          @menu = 1
        elsif argument == 2
          CLIMethods.saved_like_dislike(@random_artist_song, Like)
          @menu = 1
        end
      elsif choice == 2
        puts
        if argument == 1
          CLIMethods.saved_like_dislike(@random_song, Dislike)
        elsif argument == 2
          CLIMethods.saved_like_dislike(@random_artist_song, Dislike)
        end
      elsif choice == 3
        puts
        if argument == 1
          random_song(@@user_1.count)
        elsif argument == 2
          random_song_by_artist(@@user_1.count)
        end
      elsif choice == 4
        puts `clear`
        @menu = 1
      end
    end

    #This method allows a user to see their likes
    def view_likes_dislikes(indicator)
      @menu = 2
      @@user_1.reload
      puts `clear`
      if indicator == 1
        user_likes_dislikes(1)
      elsif indicator == 2
        user_likes_dislikes(2)
      end
    end

    #This method will display a user's likes or dislikes depending on whether
    #the user has any
    def user_likes_dislikes(preference)
      if preference == 1
        if @@user_1.likes.count > 0
          user_all_likes_dislikes(1)
        else
          no_likes_dislikes(1)
        end
      elsif preference == 2
        if @@user_1.dislikes.count > 0
          user_all_likes_dislikes(2)
        else
          no_likes_dislikes(2)
        end
      end
    end

    #This method displays all of a user's liked or disliked songs and is passed
    #an argument in
    def user_all_likes_dislikes(indicator)
      if indicator == 1
        all_liked_disliked_songs(1)
      elsif indicator == 2
        all_liked_disliked_songs(2)
      end
    end

    #This method displays a user's liked or disliked songs and then gives a user
    #options to update, delete, go back, or exit the application
    def all_liked_disliked_songs(indicator)
      if indicator == 1
        @preference = 1
        CLIMethods.liked_disliked_songs(1)
      elsif indicator == 2
        @preference = 2
        CLIMethods.liked_disliked_songs(2)
      end
      likes_dislikes_menu
    end

    #This method is used to give a user the update, delete, go back, and exit
    #options when viewing their liked or disliked songs
    def likes_dislikes_menu
      choice_3 = STDIN.gets.chomp.to_i
      if choice_3 == 1
        remove_recent_like_dislike(@preference)
      elsif choice_3 == 2
        clear_likes_dislikes(@preference)
      elsif choice_3 == 3
        puts `clear`
        @menu = 1
      elsif choice_3 == 4
        @is_running = false
      end
    end

    #This method tells a user that they do not have any liked or disliked songs
    #It is called on if a user has 0 likes or dislikes and asks to see their liked
    #or disliked songs
    def no_likes_dislikes(indicator)
      if indicator == 1
        puts "You don't have any liked songs!"
      elsif indicator == 2
        puts "You don't have any disliked songs!"
      end
      CLIOutputs.no_likes_dislikes_menu_options
      no_likes_dislikes_menu
    end

    #This method either takes the user back to the main menu or closes the application
    def no_likes_dislikes_menu
      choice_3 = STDIN.gets.chomp.to_i
      if choice_3 == 1
        puts `clear`
        @menu = 1
      elsif choice_3 == 2
        @is_running = false
      end
    end

    #This method allows a user to remove the most recent liked or disliked song
    def remove_recent_like_dislike(indicator)
      @@user_1.reload
      if indicator == 1
        @@user_1.likes.last.destroy
      elsif indicator == 2
        @@user_1.dislikes.last.destroy
      end
    end

    #This method will clear a user's likes or dislikes and is called when a user
    #chooses to clear all of their likes or dislikes
    def clear_likes_dislikes(indicator)
      if indicator == 1
        @@user_1.likes.destroy_all
      elsif indicator == 2
        @@user_1.dislikes.destroy_all
      end
    end

    #This method is the settings menu where a user can modify the amount of
    #random songs that are displayed this modifies the database as well so the
    #user's count persists if they exit the program.
    def settings
      puts `clear`
      @main = 2
      CLIOutputs.settings_menu
      x = STDIN.gets.chomp
      if x.to_i == 0
        @main = 1
      elsif x.to_i > 0
        @@user_1.count = x.to_i
        @@user_1.save
      end
      puts `clear`
    end

end
