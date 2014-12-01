feature 'Profile page' do
  scenario 'Viewing profile' do
    user = FactoryGirl.create(:user)

    visit user_path(user)

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end

  scenario 'Editing Profile' do
    user = FactoryGirl.create(:user)

    visit user_path(user)
    click_link 'Edit Profile'

    fill_in 'Name', with: 'new username'
    click_button 'Update Profile'

    expect(page).to have_content('Profile has been updated.')
  end
end