namespace :clean do
  task all: :environment do
    Issue.destroy_all
    puts "Issues Gone"
    Cover.destroy_all
    puts "Covers Gone"
    Series.destroy_all
    puts "Series Gone"
    Release.destroy_all
    puts "Releases Gone"
    Publisher.destroy_all
    puts "Publishers Gone"
  end
end
