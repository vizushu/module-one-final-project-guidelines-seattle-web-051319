class CLI
  attr_accessor :user_1, :menu, :random_song, :is_running, :count

  def initialize
  end

  def run
    puts "Welcome to the Random Song Suggestion CLI"
    puts "Please enter your username"
    puts

    get_username
    main_menu

  end

  def get_username
    name = STDIN.gets.chomp
      puts
      if User.find_by_name(name) == nil
        @user_1 = User.create(name: name)
        puts "Welcome #{@user_1.name}."
      else
        @user_1 = User.find_by_name(name)
        puts "Welcome back #{@user_1.name}!"
    end
  end

  def main_menu
    @is_running = true
    @count = 1
    while @is_running
      @menu = 1
      if @menu == 1
        puts
        puts
        puts "Main menu"
        if @count == 1
          puts "1. Let me see a random song"
        else
          puts "1. Let me see #{@count} random songs"
        end
        puts "2. Let me see my liked songs"
        puts "3. Let me see my disliked songs"
        puts "4. Settings"
        puts "5. Exit"
        first_choice
        end
      end
    end

    def first_choice
        choice = STDIN.gets.chomp.to_i
      if choice == 1
        random_song(@count)
      elsif choice == 2
        view_likes
      elsif choice == 3
        view_dislikes
      elsif choice == 4
        settings
      elsif choice == 5
        @is_running = false
      end
    end

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

    def random_song(number_of_songs)
      @random_song = filter_songs.sample(number_of_songs)
          puts
          puts "Random song(s):"
          @random_song.each_with_index do |song, index|
          puts "#{index+1}. #{song.name} by: #{song.artist}"
          end
          puts
          puts "Options:"
          if @count == 1
            puts "1. Save this song to my likes"
          else
            puts "1. Save these songs to my likes"
          end
          puts "2. Save this song to my dislikes"
          puts "3. Go back"
          puts
          saved_song
    end

    def saved_song
      @menu = 2
        choice_2 = STDIN.gets.chomp.to_i
        if choice_2 == 1
          puts
          @random_song.each_with_index do |song, index|
            Like.create(user_id: @user_1.id, song_id: song.id)
            puts "#{index+1}. #{song.name} by: #{song.artist} saved to likes!"
          end
          @menu = 1
        elsif choice_2 == 2
          puts
          @random_song.each_with_index do |song, index|
            Dislike.create(user_id: @user_1.id, song_id: song.id)
            puts "#{index+1}. #{song.name} by: #{song.artist} saved to dislikes!"
          end
          @menu = 1
        elsif choice_2 == 3
          @menu = 1
        end
      end

    def view_likes
      puts
      @menu = 2
      @user_1.reload
      if @user_1.likes.count > 0
        user_all_likes
      else
        user_no_likes
      end
    end

    def user_all_likes
      puts "Liked song(s):"
      @user_1.likes.each_with_index do |like, index|
        puts "#{index+1}. #{like.song.name} by: #{like.song.artist}"
      end
      puts
      puts "Options:"
      puts "1. Remove most recent like"
      puts "2. Clear all likes"
      puts "3. Go back"
      puts "4. Exit"
      choice_3 = STDIN.gets.chomp.to_i
      if choice_3 == 1
        remove_recent_like
      elsif choice_3 == 2
        clear_likes
      elsif choice_3 == 3
        @menu = 1
      elsif choice_3 == 4
        @is_running = false
      end
    end

    def user_no_likes
      puts "You don't have any liked songs!"
      puts
      puts "Options:"
      puts "1. Go back"
      puts "2. Exit"
      choice_3 = STDIN.gets.chomp.to_i
      if choice_3 == 1
        @menu = 1
      elsif choice_3 == 2
        @is_running = false
      end
    end

    def remove_recent_like
      @user_1.reload
      @user_1.likes.last.destroy
    end

    def clear_likes
      @user_1.likes.destroy_all
    end

    def view_dislikes
      puts
      @user_1.reload
      if @user_1.dislikes.count > 0
        user_all_dislikes
      else
        user_no_dislikes
      end
    end

    def user_all_dislikes
      puts "Disliked song(s):"
      @user_1.dislikes.each_with_index do |dislike, index|
        puts "#{index+1}. #{dislike.song.name} by: #{dislike.song.artist}"
      end
      puts
      puts "Options::"
      puts "1. Remove most recent dislike"
      puts "2. Clear all dislikes"
      puts "3. Go back"
      puts "4. Exit"
      choice_3 = STDIN.gets.chomp.to_i
      if choice_3 == 1
        remove_recent_dislike
      elsif choice_3 == 2
        clear_dislikes
      elsif choice_3 == 3
        @menu = 1
      elsif choice_3 == 4
        @is_running = false
      end
    end

    def user_no_dislikes
      puts "You don't have any disliked songs!"
      puts
      puts "Options:"
      puts "1. Go back"
      puts "2. Exit"
      choice_3 = STDIN.gets.chomp.to_i
      if choice_3 == 1
        @menu = 1
      elsif choice_3 == 2
        @is_running = false
      end
    end

    def remove_recent_dislike
      @user_1.reload
      @user_1.dislikes.last.destroy
    end

    def clear_dislikes
      @user_1.dislikes.destroy_all
    end

    def settings
      @main = 2
      puts
      puts "Settings:"
      puts "Enter the amount of random songs you want to see at one time."
      puts "Press any non numerical character to go back"
      x = STDIN.gets.chomp
        if x.to_i == 0
          @main = 1
        elsif x.to_i > 0
          @count = x.to_i
        end
    end

end
