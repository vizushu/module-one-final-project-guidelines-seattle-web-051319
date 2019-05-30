require_relative '../config/environment'

def get_songs
    songs = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&page=1&api_key=#{API_KEY}&format=json")
    parsed_songs = JSON.parse(songs)
end

def get_songs_2
    songs = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&page=2&api_key=#{API_KEY}&format=json")
    parsed_songs = JSON.parse(songs)
end

def get_songs_3
    songs = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&page=3&api_key=#{API_KEY}&format=json")
    parsed_songs = JSON.parse(songs)
end

def get_songs_4
    songs = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&page=4&api_key=#{API_KEY}&format=json")
    parsed_songs = JSON.parse(songs)
end

def get_songs_5
    songs = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&page=5&api_key=#{API_KEY}&format=json")
    parsed_songs = JSON.parse(songs)
end

def create_songs(song_data)
  song_data["tracks"]["track"].each do |track|
    Song.create(name: track["name"], artist: track["artist"]["name"])
  end
end

create_songs(get_songs)
create_songs(get_songs_2)
create_songs(get_songs_3)
create_songs(get_songs_4)
create_songs(get_songs_5)
