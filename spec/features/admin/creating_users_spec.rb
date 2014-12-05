feature 'Creating users' do
  let!(:admin) { FactoryGirl.create(:admin_user) }

  before do
    sign_in_as!(admin)

    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link 'New User'
  end

  scenario 'Creating a user' do
    fill_in 'E-mail', with: 'g@h.h'
    fill_in 'Password', with: 'password'
    click_button 'Create User'

    expect(page).to have_content('User has been created.')
  end

  scenario 'Creating a admin user' do
    fill_in 'E-mail', with: 'g@h.h'
    fill_in 'Password', with: 'password'
    check 'Is an admin?'
    click_button "Create User"

    expect(page).to have_content("User has been created")

    within("#users") do
      expect(page).to have_content("g@h.h (Admin)")
    end
  end
end