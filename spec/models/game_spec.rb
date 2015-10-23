require 'spec_helper'
require_relative '../../app'

describe Game do
  describe "#new" do
    let(:game) { Game.new(title: "Instant Human, Just Add Coffee", url: "http://www.yep.com", short_title: "caffiene")}

    it "is a game object with a title, url and short title" do
      expect(game.title).to eq("Instant Human, Just Add Coffee")
      expect(game.url).to eq("http://www.yep.com")
      expect(game.short_title).to eq("caffiene")
      expect(game).to be_a(Game)
    end
  end
end
