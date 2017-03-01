require 'rails_helper'

feature 'Authentication' do
  let(:email) { 'new_user@bloc.com' }
  let(:password) { 'password' }
  let(:username) { 'new_user' }

  scenario "signs in with correct credentials" do
    create(:user, email: email, password: password, password_confirmation: password, username: username)
    visit(new_user_session_path)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
end
