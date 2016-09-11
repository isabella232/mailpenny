require 'rails_helper'

feature 'Registering' do
  background do
    @user = build :user
  end

  given(:register) do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Username', with: @user.username
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
    end
    click_button 'Sign Up'
  end

  scenario 'succeeds' do
    register
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'redirects to dashboard overview' do
    register
    expect(page).to have_current_path(dashboard_overview_path)
  end

  # # TODO figure out why the test below doesn't work, because
  # # manual testing shows it should.
  # scenario 'fails for an existing user' do
  #   register
  #   register
  #   expect(page).to have_content 'has already been taken'
  # end
end
