class CLIOutputs

  attr_accessor :a, :b

  @a = Artii::Base.new
  @b = Artii::Base.new :font => 'slant'

  def self.welcome
    puts @b.asciify('Welcome to the')
    sleep(1)
    puts @b.asciify('Random Song CLI !')
    sleep(1)
    puts "Please enter your username"
    puts
  end

  def self.main_menu
    puts
    puts
    puts @a.asciify('Main menu')
  end

  def self.options
    puts
    puts @a.asciify('Options')
  end

  def self.main_menu_options
    puts "3. Let me see my liked songs"
    puts "4. Let me see my disliked songs"
    puts "5. Settings"
    puts "6. Exit"
  end

  def self.random_song_title
    puts `clear`
    puts @a.asciify('Random song ( s ) :')
  end

  def self.one_random_song_options
    puts "1. Save this song to my likes"
    puts "2. Save this song to my dislikes"
    puts "3. Give me another random song"
  end

  def self.one_random_song_by_artist_options
    puts "1. Save this song to my likes"
    puts "2. Save this song to my dislikes"
    puts "3. Give me another random song by an artist"
  end

  def self.multiple_random_song_options
    puts "1. Save these songs to my likes"
    puts "2. Save these songs to my dislikes"
  end

  def self.liked_songs_title
    puts @a.asciify('Liked song ( s ) :')
  end

  def self.likes_menu_options
    self.options
    puts "1. Remove most recent like"
    puts "2. Clear all likes"
    puts "3. Main menu"
    puts "4. Exit"
  end

  def self.disliked_songs_title
    puts @a.asciify('Disliked song ( s ) :')
  end

  def self.dislikes_menu_options
    self.options
    puts "1. Remove most recent dislike"
    puts "2. Clear all dislikes"
    puts "3. Main menu"
    puts "4. Exit"
  end

  def self.no_likes_dislikes_menu_options
    self.options
    puts "1. Main menu"
    puts "2. Exit"
  end

  def self.settings_menu
    puts `clear`
    puts @a.asciify('Settings')
    puts "1. Enter the amount of random songs you want to see at one time."
    puts "2. Press any non numerical character to go back"
  end
end
