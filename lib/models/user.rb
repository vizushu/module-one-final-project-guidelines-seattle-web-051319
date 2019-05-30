class User < ActiveRecord::Base
  has_many :likes 
  has_many :songs, through: :likes
  has_many :dislikes
  has_many :songs, through: :dislikes
end
