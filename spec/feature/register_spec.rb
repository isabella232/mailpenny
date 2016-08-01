require 'rails_helper'

feature 'Register' do
  background do
    @user = build :user
  end

  given(:register) do
    visit '/register'
    within('#new_user') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
    end
    click_button 'Sign up'
  end

  scenario 'succeeds with correct credentials' do
    register
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'redirects to dashboard overview' do
    register
    expect(page).to have_current_path(dashboard_overview_path)
  end

  scenario 'fails for an existing user' do
    register
    register
    expect(page).to have_content 'error prohibited'
  end
end
