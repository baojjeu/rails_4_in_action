feature 'Creating Projects' do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))

    visit '/'
    click_link 'New Project'
  end

  scenario 'Creating a project' do
    fill_in 'Name', with: 'Sublime Text 2'
    fill_in 'Description', with: 'Awesome editor'
    click_button 'Create Project'

    expect(page).to have_content('Project has been created.')

    project = Project.where(name: 'Sublime Text 2').first

    expect(page.current_url).to eql(project_url(project))

    title = 'Sublime Text 2 - Projects - Ticketee'
    expect(page).to have_title(title)
  end

  scenario 'Can not create a project without name' do
    click_button 'Create Project'
    expect(page).to have_content('Project has not been created.')
    expect(page).to have_content("Name can't be blank")
  end
end