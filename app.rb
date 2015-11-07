require "sinatra"
require "twilio-ruby"
require "sinatra/activerecord"
require "./config/environments"

Dir['app/**/*.rb'].each { |file| require_relative file }

get "/sms-green-door" do
  recieved_text = Text.new(params[:Body])

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message recieved_text.determine_response
  end

  twiml.text
end

get "/" do
  redirect "/games"
end

get "/games" do
  game_list = Game.all
  erb :index, locals: {game_list: game_list}
end

get "/games/:id" do
  game = Game.find(params[:id])
  erb :edit, locals: {game: game}
end

post "/games" do
  my_game = Game.new(params[:game])

  if my_game.save
    redirect "/games"
  else
    erb :index, locals: { game: game }
  end
end

delete "/games/:id" do
  game_to_delete = Game.find(params[:id])
  game_to_delete.destroy
  # Rails.logger.warn "Deleting game ---#{game_to_delete.inspect}---"
  redirect "/games"
end
