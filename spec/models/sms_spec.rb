require 'spec_helper'
require_relative '../../app'

describe Sms do
let(:sms) { Sms.new("Lindy Hop") }

  describe "#new" do
    it "is a Sms" do
      expect(sms).to be_a(Sms)
    end
  end

  describe "#determine_response" do
    before(:all) do
      Game.create(title: "a", url: "b", short_title: "lindy hop")
      Game.create(title: "ab", url: "bb", short_title: "lindy hop 2")
      Game.create(title: "aba", url: "bba", short_title: "not relevant")
      Game.create(title: "abaa", url: "bbaa", short_title: "lindy hop 21")
    end

    it "returns the correct response finding one game" do
      single_game = Sms.new("Lindy Hop 21")
      expect(single_game.determine_response).to eq("Visit bbaa to play abaa.  Enjoy!")
    end

    it "returns the correct response finding two games" do
      two_games = Sms.new("Lindy Hop 2")
      expect(two_games.determine_response).to eq("If you are looking for ab, visit bb, if you meant abaa, visit bbaa")
    end

    it "returns the correct response finding no games" do
      no_games = Sms.new("Lindy Hop 4444")
      expect(no_games.determine_response).to eq("I'm sorry, I don't know that game!")
    end

    it "returns the correct response finding three games" do
      three_games = Sms.new("Lindy Hop")
      expect(three_games.determine_response).to eq("I know several games that have lindy hop in them.  Could you be more specific?")
    end
  end
end
