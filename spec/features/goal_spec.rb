require 'spec_helper'
require 'rails_helper'

feature "User can do CRUD operations when logged in" do
  given(:goal) { build(:goal) }
  given(:public_goal) { build(:public_goal) }
  background :each do
    sign_in(goal.goal_setter)
  end

  scenario "when user is logged in, can set goals from homepage" do
    visit user_url(goal.user)
    fill_in "Goal", with: goal.content
    page.choose (goal.private ? "Private" : "Public")
    click_button "Create Goal"

    expect(page).to have_content(goal.content)
  end

  scenario 'when logged in, all goals are available on the homepage' do
    user = goal.goal_setter
    user.goals.create(content: "Eat more chicken", private: true)
    user.goals.create(content: "Exercise more", private: true)
    user.goals.create(content: "Wake up earlier", private: true)
    visit user_url(user)

    expect(page).to have_content("Eat more chicken")
    expect(page).to have_content("Exercise more")
    expect(page).to have_content("Wake up earlier")
    expect(page).to have_content(goal.content)
  end

  scenario 'users can read other users public goals' do
    visit user_url(public_goal.goal_setter)

    expect(page).to have_content(public_goal.content)
  end

  feature 'users can update their goals' do


    scenario 'when logged in, edit buttons appear by all goals on the homepage' do
      expect(page).to have_button("Edit")
    end

    scenario 'clicking edit takes the user to the edit page for their goal' do
      click_button('Edit')

      expect(current_path).to eq(edit_goal_path(goal))
    end

    scenario 'saving the update works' do
      visit edit_goal_url(goal.id)

      fill_in "Goal", "Now I don't want chicken anymore"
      click_button("Save Changes")
      expect(current_path).to eq(user_url(goal.goal_setter))
      expect(page).to have_content("I don't want chicken")
    end
  end

  feature 'users can delete their goals' do

    scenario 'when logged in, delete buttons are available for goals' do
      expect(page).to have_button("Delete")
    end

    scenario 'deleting actually deletes' do
      content = goal.content
      click_button "Delete"

      expect(page).to_not have_content(content)
    end

  end

end

    ###################################################
    # Now logged off
    ###################################################

feature "non-logged in user cannot see, edit, or write goals" do
  given(:goal) { build(:goal) }

  scenario "when a user is not logged in, they cannot read any goals" do
    visit goal_url(goal)

    expect(current_path).to eq(new_session_path)
  end

  scenario "when a user is not logged in, they cannot see any edit pages" do
    visit edit_goal_url(goal)

    expect(current_path).to eq(new_session_path)
  end
end
