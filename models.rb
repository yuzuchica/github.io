require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :times
  has_many :historys
end

class Time < ActiveRecord::Base
  belongs_to :user
end

class History < ActiveRecord::Base
  belongs_to :user
end
