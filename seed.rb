# execute with 'RACK_ENV=production bundle exec volt runner seed.rb'

require 'csv'
require 'time'

# CATEGORIES = %w(Snack Mittagessen Einkauf Markt Sonstiges)
#
# categories_collection = Volt.current_app.store._categories
#
# categories_collection.reverse.each {|cc| cc.destroy}
#
# CATEGORIES.each do |c|
#   categories_collection
#     .create(name: c)
#     .then {|success| puts "#{c} added." }
#     .fail {|error| puts "Failed to add category #{c}. #{error}"}
# end

expenses_collection = Volt.current_app.store._expenses

CSV.foreach('expenses.csv', :headers => false) do |row|
  expenses_collection
    .create(description: row[0], amount: row[2].delete(" €").sub(/,/, '.').to_f, created_at: Time.parse(row[1]), category_id: Volt.current_app.store._categories.where(name: row[3]).first.id, user_id: Volt.current_app.store._users.first.id)
    .then {|success| puts "#{row} added." }
    .fail {|error| puts "Failed to add expense #{row}. #{error}"}
end
