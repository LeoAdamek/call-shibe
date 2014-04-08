require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/api/*_spec.rb']
end

task :environment do
  ENV["RACK_ENV"] ||= 'development'
  require File.expand_path("../config/environment", __FILE__)
end

task :routes => :environment do
  CallShibe::API.routes.each do |route|
    p route.to_s
  end
end

require 'rubocop/rake_task'
Rubocop::RakeTask.new(:rubocop)

desc <<DESCRIPTION
Create a new API User
An API user will be created with a randomly generate access_token.

Usage:
    #{ARGV[0]} adduser[<name>]

DESCRIPTION
task :adduser, [:name] => :environment do |t, args|

  fail "Must have a name" if args[:name].nil?

  api_user = APIUser.new(:name => args[:name])

  if api_user.save
    data = [
            ["Name" , api_user.name],
            ["Access Token" , api_user.access_token],
            ["Is Enabled"   , api_user.is_enabled ? "Yes" : "No"]
           ]

    puts Terminal::Table.new :rows => data
  else
    fail "Unable to save API User."
  end
  
end

desc "List all API Users"
task :users => [:environment] do |t, args|

  users = APIUser.all

  rows = []
  users.each do |u|
    rows << [u.name , u.access_token , u.is_enabled ? "Yes" : "No" , u.created_at]
  end

  table = Terminal::Table.new :headings => %w[User Token Enabled? Created] , :rows => rows

  puts table

end


task default: [:rubocop, :spec]
