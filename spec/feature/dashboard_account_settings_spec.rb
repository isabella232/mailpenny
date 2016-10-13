require 'rails_helper'

feature 'Dashboard' do
  background do
    @user = create :user # create a new user
    @user_changed = build :user # build an alternative user

    # login as @user
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
    end
    click_button 'Log in'
  end

  scenario 'fail to change username on incorrect password' do
    visit '/dashboard/account'
    within '#edit_user' do
      fill_in 'Username', with: @user_changed.username
      fill_in 'Old pass', with: "incorrect_#{@user.password}"
    end
    click_button 'Update'
    expect(page).to have_content 'password is invalid'
  end

  # context 'in account settings' do
  #   scenario 'change username successfully' do
  #     visit '/dashboard/account'
  #     within '#edit_user' do
  #       fill_in 'Username', with: @user_changed.username
  #       fill_in 'Old pass', with: @user.password
  #     end
  #     click_button 'Update'
  #     expect(page).to have_content 'Your account has been updated successfully.'
  #   end
  # end
end
