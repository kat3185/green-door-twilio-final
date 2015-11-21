class Sms
  attr_reader :body
  def initialize(body)
    @body = body.downcase
  end

  def games
    @games ||= Game.short_title_like(body).to_a
  end

  def determine_response
    case games.length
    when 0
      "I'm sorry, I don't know that game!"
    when 1
      "Visit #{games.first.url} to play #{games.first.title}.  Enjoy!"
    when 2
      "If you are looking for #{games.first.title}, visit #{games.first.url}, if you meant #{games.second.title}, visit #{games.second.url}"
    else
      "I know several games that have #{body} in them.  Could you be more specific?"
    end
  rescue
    "This robot is temporarily broken!  Sorry :("
  end
end
