class User < ActiveRecord::Base
  attr_accessible :fb_birthday, :fb_gender, :fb_id, :fb_name, :fb_token
end
