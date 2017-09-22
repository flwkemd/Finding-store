class Comment < ActiveRecord::Base
  resourcify
  include Authority::Abilities
  
  belongs_to :post
  belongs_to :user
end
