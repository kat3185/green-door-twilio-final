require "sinatra"
require "twilio-ruby"
require "sinatra/activerecord"
require "./config/environments"

class Game < ActiveRecord::Base
  #model
end

class Text
attr_reader :games
  def initialize(body)
    @body = body
    @games = Array.new
  end

  def find_games
    Game.all.each do |game|
      if game.short_title.downcase.include?(@body.downcase)
        @games << game
      end
    end
  end

  def determine_response
    if @games.length == 1
      "Visit #{@games.first.url} to play #{@games.first.title}.  Enjoy!"
    elsif @games.length == 2
      "If you are looking for #{@games.first.title}, visit #{@games.first.url}, if you meant #{@games.second.title}, visit #{@games.second.url}"
    elsif @games.empty?
        "I'm sorry, I don't know that game!"
    else
      "I know several games that have #{@body} in them.  Could you be more specific?"
    end
  end

  def return_response
    find_games
    determine_response
  end

end

get "/sms-green-door" do

  recieved_text = Text.new(params[:Body])

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message recieved_text.return_response
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

post "/DestroyGame" do
  game_to_delete = Game.find(params[:game_id])
  game_to_delete.destroy
  redirect "/games"
end
