require 'sequel'
#require 'sqlite3'

DB = Sequel.connect('sqlite://game.db')
puts DB



DB.create_table? :games do
  primary_key :id
  String :name
  Integer :state
  Integer :substate
  Float :money
  Integer :life
  Integer :fights
  Integer :respect
end

items = DB[:games]

# populate the table
#puts items.insert(:name => 'abc', :money => rand * 100)
#items.insert(:name => 'def', :price => rand * 100)
#items.insert(:name => 'ghi', :price => rand * 100)


