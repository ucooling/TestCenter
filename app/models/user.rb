class User < ActiveRecord::Base
  attr_accessible :authority_id, :password, :username
end
