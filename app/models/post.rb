class Post < ActiveRecord::Base
  resourcify
  include Authority::Abilities   
   
    has_many :comments
    belongs_to :user
end
