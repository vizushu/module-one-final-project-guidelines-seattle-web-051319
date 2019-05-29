require_relative '../config/environment'

def get_songs
  songs = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=#{API_KEY}&format=json")
  parsed_songs = JSON.parse(songs)
end

def create_songs(song_data)
  song_data["tracks"]["track"].each do |track|
    Song.create(name: track["name"], artist: track["artist"]["name"])
  end
end

create_songs(get_songs)
