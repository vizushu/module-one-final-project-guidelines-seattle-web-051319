class Artist < ActiveRecord::Base
  has_many :songs
  has_many :likes, through: :songs
  has_many :dislikes, through: :songs
end
