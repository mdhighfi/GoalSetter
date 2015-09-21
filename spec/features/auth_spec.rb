require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  given(:user) { build(:user) }

  scenario "has a new user page" do
    visit new_user_url

    expect(current_path).to eq('/users/new')
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign Up"

      expect(page).to have_content(user.username)
    end

  end
end

feature "logging in" do
  given(:user) { create(:user) }

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Log In"

    expect(page).to have_content(user.username)
  end

end

feature "logging out" do
  given(:user) { create(:user) }

  scenario "begins with logged out state" do
    visit user_url(user)

    expect(page).to_not have_content("Log Out")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Log In"
    click_button("Log Out")

    expect(page).to_not have_content(user.username)
  end

end
