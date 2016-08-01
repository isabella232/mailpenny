require 'rails_helper'

feature 'Signing in' do
  background do
    @user = create(:user)
  end

  given(:sign_in) do
    visit '/login'
    within('#new_user') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
    end
    click_button 'Log in'
  end

  scenario 'succeeds with correct credentials' do
    sign_in
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'fails with incorrect credentials' do
    visit '/login'
    within('#new_user') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: "incorrect_#{@user.password}"
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password'
  end

  scenario 'Sign in redirects to dashboard overview' do
    sign_in
    expect(page).to have_current_path(dashboard_overview_path)
  end
end
