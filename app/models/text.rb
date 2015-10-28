class Text
  attr_reader :body, :games
  def initialize(body)
    @body = body.downcase
  end

  def find_games
    @games = Game.where("LOWER(short_title) LIKE ?", "%#{body}%").to_a
  end

  def determine_response
    if games.length == 1
      "Visit #{games.first.url} to play #{games.first.title}.  Enjoy!"
    elsif games.length == 2
      "If you are looking for #{games.first.title}, visit #{games.first.url}, if you meant #{games.second.title}, visit #{games.second.url}"
    elsif games.empty?
        "I'm sorry, I don't know that game!"
    else
      "I know several games that have #{body} in them.  Could you be more specific?"
    end
  end

  def return_response
    find_games
    determine_response
  end
end
