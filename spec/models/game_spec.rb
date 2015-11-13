require 'spec_helper'

describe Game do
  describe "#new" do
    let!(:game) { Game.new(title: "Instant Human, Just Add Coffee", url: "http://www.yep.com", short_title: "caffiene")}

    it "is a game object with a title, url and short title" do
      expect(game.title).to eq("Instant Human, Just Add Coffee")
      expect(game.url).to eq("http://www.yep.com")
      expect(game.short_title).to eq("caffiene")
      expect(game).to be_a(Game)
    end

  end
  describe "#short_title_like" do
    let!(:game) { Game.new(title: "Instant Human, Just Add Coffee", url: "http://www.yep.com", short_title: "caffiene")}
    it "finds games based on their short title" do
      game.save
      expect(Game.short_title_like("caf").to_a).to eq([game])
    end

    it "returns all relevant games" do
      2.times do game.save end
      expect(Game.short_title_like("caf").to_a.length).to eq(2)
    end
  end
end
