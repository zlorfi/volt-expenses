# execute with 'RACK_ENV=production bundle exec volt runner seed.rb'

CATEGORIES = %w(Snack Mittagessen Einkauf Markt Sonstiges)

categories_collection = Volt.current_app.store._categories

categories_collection.reverse.each {|cc| cc.destroy}

CATEGORIES.each do |c|
  categories_collection
    .create(name: c)
    .then {|success| puts "#{c} added." }
    .fail {|error| puts "Failed to add category #{c}. #{error}"}
end
