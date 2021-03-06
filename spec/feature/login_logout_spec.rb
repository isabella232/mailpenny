# require 'rails_helper'
#
# feature 'Login & Logout:' do
#   background do
#     @user = create(:user)
#   end
#
#   given(:login) do
#     visit 'users/sign_in'
#     within('#new_user') do
#       fill_in 'Email', with: @user.email
#       fill_in 'Password', with: @user.password
#     end
#     click_button 'Log in'
#   end
#
#   context 'upon login' do
#     scenario 'succeed with correct credentials' do
#       login
#       expect(page).to have_content 'Signed in successfully'
#     end
#
#     scenario 'fail with incorrect credentials' do
#       visit 'users/sign_in'
#       within('#new_user') do
#         fill_in 'Email', with: @user.email
#         fill_in 'Password', with: "incorrect_#{@user.password}"
#       end
#       click_button 'Log in'
#       expect(page).to have_content 'Invalid Email or password'
#     end
#   end
#
#   context 'upon logout' do
#     scenario 'be successful' do
#       login
#       visit dashboard_account_path
#       click_link 'Logout'
#       expect(page).to have_content 'Signed out successfully.'
#     end
#
#     scenario 'redirect to dashboard overview' do
#       login
#       visit dashboard_account_path
#       click_link 'Logout'
#       expect(page).to have_current_path(root_path)
#     end
#   end
# end
