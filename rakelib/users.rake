
namespace :user do
  desc "List all API Users"
  task :list => [:environment] do |t, args|

    users = APIUser.all

    rows = []
    users.each do |u|
      rows << [u.name , u.access_token , u.is_enabled ? "Yes" : "No" , u.created_at]
    end

    table = Terminal::Table.new :headings => %w[User Token Enabled? Created] , :rows => rows

    puts table

  end

  desc <<DESCRIPTION
Create a new API User
An API user will be created with a randomly generate access_token.

Usage:
    #{ARGV[0]} adduser[<name>]

DESCRIPTION
  task :add, [:name] => :environment do |t, args|

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

  desc 'Delete an API User'
  task :delete, [:name] => :environment do |t,args|
    fail "Don't know who to delete" if args[:name].nil?

    user = APIUser.find_by(:name => args[:name])
    
    fail "Don't know the user #{args[:name]}" if user.nil?

    user.delete
  end


  desc 'Disable an API User'
  task :disable, [:name] => :environment do |t,args|
    fail "Don't know who to disable" if args[:name].nil?

    user = APIUser.find_by(:name => args[:name])

    fail "Don't know the user #{args[:name]}" if user.nil?
    
    user.is_enabled = false
    user.save
  end

  desc 'Enable an API User'
  task :enable, [:name] => :environment do |t,args|
    fail "Don't know who to enable" if args[:name].nil?

    user = APIUser.find_by(:name => args[:name])
    
    fail "Don't know the user #{args[:name]}" if user.nil?

    user.is_enabled = true
    user.save
  end


end
