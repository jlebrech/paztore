# This file contains your application, it requires dependencies and necessary
# parts of the application.
require 'rubygems'
require 'ramaze'
require 'sequel'

DB_CONFIG = YAML.load(File.read(File.join(__DIR__, 'database.yml')))
DB = Sequel.connect(DB_CONFIG[Ramaze.options[:mode].to_s])

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]

require __DIR__('controller/init')
