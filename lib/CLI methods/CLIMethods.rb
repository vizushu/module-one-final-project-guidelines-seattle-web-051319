class CLIMethods

  #This method saves a song or songs to a user's liked songs and then returns
  #the user to the main menu
  def self.saved_like_dislike(song_collection, preference)
    puts `clear`
    song_collection.each_with_index do |song, index|
      preference.create(user_id: CLI.user_1.id, song_id: song.id)
      puts "#{index+1}. #{song.name} by: #{song.artist.name} saved to #{preference.to_s.downcase.pluralize}!"
    end
  end

  #This method is called upon in all_liked_disliked_songs and displays all of
  #a user's liked songs
  def self.liked_disliked_songs(preference)
    if preference == 1
      CLIOutputs.liked_songs_title
      CLI.user_1.likes.each_with_index do |like, index|
        puts "#{index+1}. #{like.song.name} by: #{like.song.artist.name}"
      end
      CLIOutputs.likes_menu_options
    elsif preference == 2
      CLIOutputs.disliked_songs_title
      CLI.user_1.dislikes.each_with_index do |dislike, index|
        puts "#{index+1}. #{dislike.song.name} by: #{dislike.song.artist.name}"
      end
      CLIOutputs.dislikes_menu_options
    end
  end

end
