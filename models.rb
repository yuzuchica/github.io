require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :works
  has_many :histories
end

class History < ActiveRecord::Base
  belongs_to :user
end

class Work < ActiveRecord::Base
  belongs_to :User
end