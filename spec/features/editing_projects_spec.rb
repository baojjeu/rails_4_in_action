require 'rails_helper'

feature 'Editing Projects' do
  before do
    FactoryGirl.create(:project, name: 'Sublime Text 3')

    visit '/'
    click_link 'Sublime Text 3'
    click_link 'Edit'
  end

  scenario 'can edit a project' do
    fill_in 'Name', with: 'Sublime Text 3 beta'
    click_button 'Update Project'

    expect(page).to have_content('Project has been updated.')
  end

  scenario 'can not update a project with invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Project'

    expect(page).to have_content('Project has not been updated.')
  end
end