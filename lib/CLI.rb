class CLI
  def initialize
  end

  def run
    puts "Welcome to the Random Song Suggestion CLI"
    main_menu
  end

  def main_menu
    is_running = true
    puts "1. Give me a random song"
    puts "2. Let me see my liked songs"
    puts "3. Exit"
    while is_running
      choice = STDIN.gets.chomp.to_i
      if choice == 1
        puts Song.all.sample.name
      elsif choice == 2
        User.likes
      elsif choice == 3
        is_running = false
      end
    end
  end

end
