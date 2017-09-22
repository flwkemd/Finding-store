class User < ActiveRecord::Base
    has_many :verifications
end
