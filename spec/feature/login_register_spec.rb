require 'rails_helper'

feature 'Signing in' do
  background do
    @user = create(:user)
  end

  scenario 'Signing in with correct credentials' do
    visit '/login'
    within('#new_user') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Signing in with correct credentials' do
    visit '/login'
    within('#new_user') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: "incorrect_#{@user.password}"
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password'
  end
end
