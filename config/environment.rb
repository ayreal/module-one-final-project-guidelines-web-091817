require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development')
require_all 'lib'
# require_all 'bin'

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
