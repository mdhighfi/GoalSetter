require 'capybara/rspec'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end

def sign_in(user)
  visit new_session_url
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Log In"
end

def set_goals_for_user(user, n)
  n.times do
    user.goals.create!()
  end
end
