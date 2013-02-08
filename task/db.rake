namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
    require 'sequel'
  end
end

def __DIR__
  File.dirname(__FILE__)
end 
 
task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
  DB_CONFIG = YAML.load(File.read(File.join(__DIR__, '../database.yml')))
  DB = Sequel.connect(DB_CONFIG[ENV["RACK_ENV"]])
end
 
namespace :db do
  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
 
    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(DB, "migrations")
  end
 
  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
 
    require 'sequel/extensions/migration'
    version = (row = DB[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(Foo::Database, "db/migrate", version - 1)
  end
 
  desc "Nuke the database (drop all tables)"
  task :nuke, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    DB.tables.each do |table|
      DB.run("DROP TABLE #{table}")
    end
  end
 
  desc "Reset the database"
  task :reset, [:env] => [:nuke, :migrate]
end