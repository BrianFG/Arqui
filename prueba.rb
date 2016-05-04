require 'sequel'
#require 'sqlite3'

DB = Sequel.connect('sqlite://game.db')




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





