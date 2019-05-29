class CLI
  attr_accessor :user_1, :menu, :random_song

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
      if User.find_by_name(name) == nil
        @user_1 = User.create(name: name)
      else
        @user_1 = User.find_by_name(name)
    end
  end

  def main_menu
    is_running = true
    while is_running
      @menu = 1
      if @menu == 1
        puts
        puts "1. Give me a random song"
        puts "2. Let me see my liked songs"
        puts "3. Exit"
          choice = STDIN.gets.chomp.to_i
          if choice == 1
            @random_song = Song.all.sample
            puts
            puts "#{@random_song.name} by: #{@random_song.artist}"
            puts
            puts "1. Save this song to my likes"
            puts "2. Go back"
            puts
            
          saved_song

          elsif choice == 2
            puts
            @user_1 = User.find(@user_1.id)
            @user_1.likes.each do |like|
              puts "#{like.song.name} by: #{like.song.artist}"
              end
            @menu = 2
            puts
            puts "1. Go back"
            puts "2. Exit"
            choice_3 = STDIN.gets.chomp.to_i
            if choice_3 == 1
              @menu = 1
            elsif choice_3 == 2
              is_running = false
            end
          elsif choice == 3
            is_running = false
          end
        end
      end
    end

    def saved_song
      @menu = 2
            choice_2 = STDIN.gets.chomp.to_i
            if choice_2 == 1
              Like.create(user_id: @user_1.id, song_id: @random_song.id)
              puts
              puts "#{@random_song.name} by: #{@random_song.artist} saved!"
              @menu = 1
            elsif choice_2 == 2
              @menu = 1
            end
      end
          
end
