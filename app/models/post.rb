class Post < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  attr_accessible :comment, :photo, :star
end
