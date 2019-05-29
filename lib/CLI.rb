class CLI
  def initialize
  end

  def run
    puts "Welcome to the Random Song Suggestion CLI"
    puts "Please enter your username"
    
    name = STDIN.gets.chomp
      if User.find_by_name(name) == nil
        user_1 = User.create(name: name)
      else
        user_1 = User.find_by_name(name)
      end

    is_running = true
    puts "1. Give me a random song"
    puts "2. Let me see my liked songs"
    puts "3. Exit"
    while is_running
      choice = STDIN.gets.chomp.to_i
      if choice == 1
        puts Song.all.sample.name
      elsif choice == 2
        user_1.likes.each do |like|
          puts like.song.name
        end
      elsif choice == 3
        is_running = false
      end
    end
  end
end
