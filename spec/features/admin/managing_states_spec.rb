feature 'Managing states' do
  before do
    load "#{Rails.root}/db/seeds.rb"
    sign_in_as!(FactoryGirl.create(:admin_user))
  end

  scenario 'Making a state as default' do
    visit '/'
    click_link 'Admin'
    click_link 'States'
    within state_link_for('New') do
      click_link 'Make Default'
    end

    expect(page).to have_content 'New is now the default state.'
  end
end
