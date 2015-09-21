require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  given(:user1) { build(:user) }

  scenario "has a new user page" do
    visit new_user_url

    expect(current_path).to eq('/users/new')
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in "Username", with: user1.username
      fill_in "Password", with: user1.password
      click_button "Sign Up"

      expect(page).to have_content(user1.username)
    end

  end
end

feature "logging in" do
  given(:user2) { create(:user) }

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in "Username", with: user2.username
    fill_in "Password", with: user2.password
    click_button "Log In"

    expect(page).to have_content(user2.username)
  end

end

feature "logging out" do
  given(:user3) { create(:user) }

  scenario "begins with logged out state" do
    visit user_url(user3)

    expect(page).to_not have_content("Log Out")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in "Username", with: user3.username
    fill_in "Password", with: user3.password
    click_button "Log In"
    click_button("Log Out")

    expect(page).to_not have_content(user3.username)
  end

end
