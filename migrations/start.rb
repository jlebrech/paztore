require File.expand_path('../app.rb', File.dirname(__FILE__))
require 'sequel/extensions/migration.rb'

Sequel::Migrator.apply(DB, '.')
