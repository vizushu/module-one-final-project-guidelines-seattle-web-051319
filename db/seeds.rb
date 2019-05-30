require_relative '../config/environment'

def get_songs
  counter = 0
  while counter < 10
    songs = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&page=#{counter+1}&api_key=#{API_KEY}&format=json")
    parsed_songs = JSON.parse(songs)
    create_artists(parsed_songs)
    create_songs(parsed_songs)
    counter += 1
  end
end

  def create_artists(song_data)
    song_data["tracks"]["track"].each do |track|
      if Artist.all.include?(Artist.find_by_name(track["artist"]["name"]))
      else
        Artist.create(name: track["artist"]["name"])
      end
    end
  end

def create_songs(song_data)
  song_data["tracks"]["track"].each do |track|
    Song.create(name: track["name"], artist: Artist.find_by_name(track["artist"]["name"]))
  end
end

get_songs
