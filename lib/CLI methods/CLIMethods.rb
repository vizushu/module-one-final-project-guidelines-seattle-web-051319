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

end
