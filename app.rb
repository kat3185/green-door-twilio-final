require "sinatra"
require "twilio-ruby"
require "sinatra/activerecord"
require "./config/environments"
require "will_paginate"
require 'will_paginate/active_record'

Dir['app/**/*.rb'].each { |file| require_relative file }

get "/sms-green-door" do
  recieved_sms = Sms.new(params[:Body])

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message recieved_sms.determine_response
  end

  twiml.text
end

get "/" do
  redirect "/games"
end

get "/games" do
  erb :index, locals: {games: Game.paginate(:page => params[:page])}
end

get "/games/:id/edit" do |id|
  erb :edit, locals: {game: Game.find(id)}
end

post "/game" do
  my_game = Game.new(params[:game])

  if my_game.save
    redirect "/games"
  else
    erb :index, locals: { games: Game.paginate(:page => params[:page])}
  end
end

put "/game/:id" do |id|
  game_to_update = Game.find(id)
  game_to_update.update(params[:game])
  game_to_update.save
  redirect "/games"
end

delete "/game/:id" do |id|
  game_to_delete = Game.find(id)
  game_to_delete.destroy
  redirect "/games"
end
