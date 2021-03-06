feature 'Editing Projects' do
  before do
    FactoryGirl.create(:project, name: 'Sublime Text 3')

    visit '/'

    sign_in_as!(FactoryGirl.create(:admin_user))

    click_link 'Sublime Text 3'
    click_link 'Edit'
  end

  scenario 'Editing a project' do
    fill_in 'Name', with: 'Sublime Text 3 beta'
    click_button 'Update Project'

    expect(page).to have_content('Project has been updated.')
  end

  scenario 'Can not update a project with invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Project'

    expect(page).to have_content('Project has not been updated.')
  end
end