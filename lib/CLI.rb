class CLI
  attr_accessor :user_1, :menu, :random_song, :is_running

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
    @is_running = true
    while @is_running
      @menu = 1
      if @menu == 1
        puts
        puts "1. Give me a random song"
        puts "2. Let me see my liked songs"
        puts "3. Let me see my disliked songs"
        puts "4. Exit"
          choice = STDIN.gets.chomp.to_i
          if choice == 1
            random_song
          elsif choice == 2
            view_likes
          elsif choice == 3
            view_dislikes
          elsif choice == 4
            @is_running = false
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
              puts "#{@random_song.name} by: #{@random_song.artist} saved to likes!"
              @menu = 1
            elsif choice_2 == 2
              Dislike.create(user_id: @user_1.id, song_id: @random_song.id)
              puts
              puts "#{@random_song.name} by: #{@random_song.artist} saved to dislikes!"
              @menu = 1
            elsif choice_2 == 3
              @menu = 1
            end
      end

      def random_song
        @random_song = Song.all.sample
            puts
            puts "#{@random_song.name} by: #{@random_song.artist}"
            puts
            puts "1. Save this song to my likes"
            puts "2. Save this song to my dislikes"
            puts "3. Go back"
            puts
            saved_song
      end

      def view_likes
        puts
        @user_1.reload
        if @user_1.likes.count > 0
          @user_1.likes.each do |like|
            puts "#{like.song.name} by: #{like.song.artist}"
          end
        else
          puts "You don't have any likes!"
        end
        @menu = 2
        puts 
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
          @user_1.dislikes.each do |dislike|
            puts "#{dislike.song.name} by: #{dislike.song.artist}"
          end
        else
          puts "You don't have any dislikes!"
        end
        @menu = 2
        puts
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

      def remove_recent_dislike
        @user_1.reload
        @user_1.dislikes.last.destroy
      end

      def clear_dislikes
        @user_1.dislikes.destroy_all
      end
end
