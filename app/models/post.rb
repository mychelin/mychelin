class Post < ActiveRecord::Base
  belongs_to :restarurant
  belongs_to :user
  attr_accessible :comment, :photo, :star
end
