require 'spec_helper'

feature "CRUD actions for Game model" do

  scenario "Create and Read a New Game" do
    visit "/games"
    expect(page).to have_content("Add a Game")
    fill_in "Title:", with: "Construct Additional Pylons"
    fill_in "Short Title:", with: "CAP"
    fill_in "URL:", with: "http://www.starcraft.com"
    click_button "Submit Game"

    expect(page).to have_content("Construct Additional Pylons")
    expect(page).to have_content("Add a Game")
  end

  scenario "Update a Game" do
    visit "/games"
    click_link "Edit"
    fill_in "Short Title:", with: "!"
    click_button "Submit Game"

    expect(page).to have_content("Construct Additional Pylons")
    expect(page).to have_content("!")
    expect(page).to have_no_content("CAP")
    expect(page).to have_content("Add a Game")
  end

  scenario "Delete a Game" do
    visit "/games"
    click_button "Delete"

    expect(page).to have_no_content("Construct Additional Pylons")
    expect(page).to have_content("Add a Game")
  end
end
