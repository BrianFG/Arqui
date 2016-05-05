# Final Project: A Text Adventure Game
# Date: 05-May-2016
# Authors: Alejandro Rojas Cepeda
#          Brian Flores Gonzalez
#          Eduardo Azuri Gaytan Martinez
#          Eduardo Rodriguez Ruiz
#          

require 'sinatra'
require 'sinatra/base'
require 'sequel'
require "json"  
require ('./models/gameFactory')

#Connects the to the DataBase
DB = Sequel.connect('sqlite://game.db')
require ('./models/game')
games = DB[:games]


enable :sessions
set :session_secret, 'SecretString#!$%'


helpers do
#Scapes special html characters to prevent html injection
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  erb :index
end


#Calls the main page.
get '/play' do
  @name = session[:name]
  erb :play
end

#Route to the play webpage, take a name as parameter and creates a new game record on the database. The id is stored on the session
get '/create_game' do
  @name = params[:name]
  if @name
    code = games.insert(name: @name, state: 7, substate: 0, money: 100, life: 100, fights: 0, respect: 0)
    session[:code] = code
    session[:name] = @name
  end  
  redirect '/play'
end 

#Calls a method on the GameController instance and displays a json containing a message, next instructions, room description and booleans to know if the game was lost or won.
get '/next' do
  method = params[:method]
  code = session[:code]
  row = games[id: code]
  game = create_game2(row[:state], row[:substate], row[:money], row[:life], row[:fights], row[:respect])
  message = game.send(method)
  stats = game.stats
  games.where(id: code).update(stats)
  "#{{:message => message,
   :instructions => game.instructions ,
    :description => game.description ,
    :lost => game.lost? ,
    :won => game.won?}.to_json}"
end

#get route that returns a json containing the current game state from database 
get '/state' do
  code = session[:code]
  row = games[id: code]
  "#{row.to_json}"
end


