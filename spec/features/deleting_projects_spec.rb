feature 'Deleting Projects' do
  before do
    FactoryGirl.create(:project, name: 'Sublime Text 3')
    visit '/'

    sign_in_as!(FactoryGirl.create(:admin_user))

    click_link 'Sublime Text 3'
  end

  scenario 'Deleting a project' do
    click_link 'Delete Project'

    expect(page).to have_content('Project has been destroyed.')
    expect(page).to have_no_content('Sublime Text 3')
  end
end