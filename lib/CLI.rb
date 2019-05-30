class CLI
  attr_accessor :user_1, :menu, :random_song, :is_running, :preference, :a

  def initialize

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
      @user_1 = User.create(name: name, count: 1)
      puts "Welcome #{@user_1.name}."
    else
      @user_1 = User.find_by_name(name)
      puts "Welcome back #{@user_1.name}!"
    end
  end

  #This method is our main menu which shows all of our main menu prompts
  def main_menu
    @is_running = true
    while @is_running
      @menu = 1
      puts `clear`
      if @menu == 1
          CLIOutputs.main_menu
        if @user_1.count == 1
          puts "1. Let me see a random song"
        else
          puts "1. Let me see #{@user_1.count} random songs"
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
        random_song(@user_1.count)
      elsif choice == 2
        view_likes_dislikes(1)
      elsif choice == 3
        view_likes_dislikes(2)
      elsif choice == 4
        settings
      elsif choice == 5
        @is_running = false
      end
    end

    #This method allows the program to filter out songs that the user has
    #already liked/disliked so they do not appear when the user requests a random song
    def filter_songs
      disliked_songs = @user_1.dislikes.map {|dislike| dislike.song}
      liked_songs = @user_1.likes.map {|like| like.song}
      removed_dislikes = Song.all.select do |song|
        disliked_songs.include?(song) == false
      end
      updated_songs = removed_dislikes.select do |song|
        liked_songs.include?(song) == false
      end
      updated_songs
    end

    #This method displays a random song or songs depending on the amount of songs
    #a user has chosen to be displayed
    def random_song(number_of_songs)
      @random_song = filter_songs.sample(number_of_songs)
      CLIOutputs.random_song_title
      @random_song.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} by: #{song.artist}"
      end
      CLIOutputs.options
      if @user_1.count == 1
        CLIOutputs.one_random_song_options
      else
        CLIOutputs.multiple_random_song_options
        puts "3. Give me #{@user_1.count} more random songs"
      end
      puts "4. Go back"
      puts
      saved_song
    end

    #This method saves a song or songs to a user's likes or dislikes, or gives
    #them another random song based on which option they choose
    def saved_song
      @menu = 2
      choice = STDIN.gets.chomp.to_i
      if choice == 1
        puts
        saved_like
      elsif choice == 2
        puts
        saved_dislike
      elsif choice == 3
        random_song(@user_1.count)
      elsif choice == 4
        @menu = 1
      end
    end

    #This method saves a song or songs to a user's liked songs and then returns
    #the user to the main menu
    def saved_like
      @random_song.each_with_index do |song, index|
        Like.create(user_id: @user_1.id, song_id: song.id)
        puts "#{index+1}. #{song.name} by: #{song.artist} saved to likes!"
      end
      @menu = 1
    end

    #This method mimics the behavior of the saved_like method but for dislikes
    def saved_dislike
      @random_song.each_with_index do |song, index|
        Dislike.create(user_id: @user_1.id, song_id: song.id)
        puts "#{index+1}. #{song.name} by: #{song.artist} saved to dislikes!"
      end
      @menu = 1
    end

    #This method allows a user to see their likes
    def view_likes_dislikes(indicator)
      @menu = 2
      @user_1.reload
      puts `clear`
      if indicator == 1
        user_likes
      elsif indicator == 2
        user_dislikes
      end
    end

    #This method as well as user_dislikes are just methods that display a user's
    #likes or dislikes depending on whether the user has any
    def user_likes
      if @user_1.likes.count > 0
        user_all_likes_dislikes(1)
      else
        no_likes_dislikes(1)
      end
    end

    def user_dislikes
      if @user_1.dislikes.count > 0
        user_all_likes_dislikes(2)
      else
        no_likes_dislikes(2)
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
        all_liked_songs
      elsif indicator == 2
        @preference = 2
        all_disliked_songs
      end
      likes_dislikes_menu
    end

    #This method is called upon in all_liked_disliked_songs and displays all of
    #a user's liked songs
    def all_liked_songs
      CLIOutputs.liked_songs_title
      @user_1.likes.each_with_index do |like, index|
        puts "#{index+1}. #{like.song.name} by: #{like.song.artist}"
      end
      CLIOutputs.likes_menu_options
    end

    #This method is called upon in all_liked_disliked_songs and displays all of
    #a user's disliked songs
    def all_disliked_songs
      @preference = 2
      CLIOutputs.disliked_songs_title
      @user_1.dislikes.each_with_index do |dislike, index|
        puts "#{index+1}. #{dislike.song.name} by: #{dislike.song.artist}"
      end
      CLIOutputs.dislikes_menu_options
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
        @menu = 1
      elsif choice_3 == 2
        @is_running = false
      end
    end

    #This method allows a user to remove the most recent liked or disliked song
    def remove_recent_like_dislike(indicator)
      @user_1.reload
      if indicator == 1
        @user_1.likes.last.destroy
      elsif indicator == 2
        @user_1.dislikes.last.destroy
      end
    end

    #This method will clear a user's likes or dislikes and is called when a user
    #chooses to clear all of their likes or dislikes
    def clear_likes_dislikes(indicator)
      if indicator == 1
        @user_1.likes.destroy_all
      elsif indicator == 2
        @user_1.dislikes.destroy_all
      end
    end

    #This method is the settings menu where a user can modify the amount of
    #random songs that are displayed this modifies the database as well so the
    #user's count persists if they exit the program.
    def settings
      @main = 2
      CLIOutputs.settings_menu
      x = STDIN.gets.chomp
      if x.to_i == 0
        @main = 1
      elsif x.to_i > 0
        @user_1.count = x.to_i
        @user_1.save
      end
    end

end
