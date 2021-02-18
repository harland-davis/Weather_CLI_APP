require 'bundler/setup'
Bundler.require

require_all 'lib'
require_all 'app'

ActiveRecord::Base.logger = nil