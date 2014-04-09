task :routes => :environment do

  rows = []

  CallShibe::API.routes.each do |r|
    rows << [r.route_method , r.route_path, r.route_description]
  end

  puts Terminal::Table.new :headings => %w[Method Path Description] , :rows => rows

end