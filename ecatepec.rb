require 'sinatra'
require 'sinatra/base'
require 'sequel'
require "json"  
require ('./models/gameFactory')

DB = Sequel.connect('sqlite://game.db')
require ('./models/game')
games = DB[:games]


enable :sessions
set :session_secret, 'SecretString#!$%'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  erb :index
end



get '/play' do
  @name = session[:name]
  erb :play
end

get '/create_game' do
  @name = params[:name]
  if @name
    code = games.insert(name: @name, state: 7, substate: 0, money: 100, life: 100, fights: 0, respect: 0)
    session[:code] = code
    session[:name] = @name
  end  
  redirect '/play'
end 

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
    :lost => game.lost?}.to_json}"
end

get '/state' do
  code = session[:code]
  row = games[id: code]
  "#{row.to_json}"
end


