require 'rails_helper'

feature 'Home Page' do
  scenario 'should have a login link' do
    visit root_path
    expect(page).to have_link(new_user_session_path)
  end
end
