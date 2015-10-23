require 'spec_helper'
require_relative '../../app'

describe Text do
let(:text) { Text.new("Lindy Hop") }

  describe "#new" do
    it "is a text" do
      expect(text).to be_a(Text)
    end
  end

  describe "#find_games" do

    it "assigns relevant games to the text (no games)" do
      text.find_games
      expect(text.games).to eq(Array.new)
    end

    it "assigns relevant games to the text (one game)" do
      Game.create(title: "a", url: "b", short_title: "Lindy Hop")
      text.find_games
      expect(text.games.length).to eq(1)
    end

    it "assigns relevant games to the text (two games)" do
      Game.create(title: "ab", url: "bb", short_title: "Lindy Hop 2")
      text.find_games
      expect(text.games.length).to eq(2)
    end

    it "assigns relevant games to the text (two games out of three)" do
      Game.create(title: "aba", url: "bba", short_title: "Not Relevant")
      text.find_games
      expect(text.games.length).to eq(2)
    end

    it "assigns relevant games to the text (three games out of four)" do
      Game.create(title: "abaa", url: "bbaa", short_title: "Lindy Hop 21")
      text.find_games
      expect(text.games.length).to eq(3)
    end
  end

  describe "#determine_response" do
    it "returns the correct response finding one game" do
      single_game = Text.new("Lindy Hop 21")
      single_game.find_games
      expect(single_game.determine_response).to eq("Visit bbaa to play abaa.  Enjoy!")
    end

    it "returns the correct response finding two games" do
      two_games = Text.new("Lindy Hop 2")
      two_games.find_games
      expect(two_games.determine_response).to eq("If you are looking for ab, visit bb, if you meant abaa, visit bbaa")
    end

    it "returns the correct response finding no games" do
      no_games = Text.new("Lindy Hop 4444")
      no_games.find_games
      expect(no_games.determine_response).to eq("I'm sorry, I don't know that game!")
    end

    it "returns the correct response finding three games" do
      three_games = Text.new("Lindy Hop")
      three_games.find_games
      expect(three_games.determine_response).to eq("I know several games that have Lindy Hop in them.  Could you be more specific?")
    end
  end
end
