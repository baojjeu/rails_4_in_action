require 'rails_helper'

feature 'Editing Projects' do
  scenario 'can edit a project' do
    FactoryGirl.create(:project, name: 'Sublime Text 3')

    visit '/'
    click_link 'Sublime Text 3'
    click_link 'Edit'
    fill_in 'Name', with: 'Sublime Text 3 beta'
    click_button 'Update Project'

    expect(page).to have_content('Project has been updated.')
  end
end