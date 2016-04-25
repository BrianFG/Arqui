require 'sinatra'
require 'sinatra/base'
require 'sequel'
require ('./clases')

DB = Sequel.connect('sqlite://game.db')
games = DB[:games]


enable :sessions
set :session_secret, 'SecretString#!$%'

get '/hi' do
  session[:count] ||= 0
  session[:count] += 1
  count = session[:count]
  game = create_game(0, 0, 100, 100, 0, 0)
  "#{game.description}"  
end 


get '/create_game' do
  name = params[:name]
  if name
    code = games.insert(name: name, state: 0, substate: 0, money: 100, life: 100, fights: 0, respect: 0)
    session[:code] = code
  end  
end 

get '/next' do
  method = params[:method]
  code = session[:code]
  row = games[id: code]
  game = create_game(row[:state], row[:substate], row[:money], row[:life], row[:fights], row[:respect])
  message = game.send(method)
  stats = game.stats
  games.where(id: code).update(stats)
  "#{message} <br>  #{game.instructions}  <br> #{game.state.description}"
end

get '/state' do
  code = session[:code]
  row = games[id: code]
  "#{row}"
end

get '/room_description' do
  code = session[:code]
  row = games[id: code]
  "#{row}"
end
