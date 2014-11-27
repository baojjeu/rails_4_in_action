feature 'Creating Tickets' do
  before do
    FactoryGirl.create(:project, name: 'Chrome')

    visit '/'
    click_link 'Chrome'
    click_link 'New Ticket'
  end

  scenario 'Creating a ticket' do
    fill_in 'Title', with: 'Lite version'
    fill_in 'Description', with: 'To avoid overusing RAM'
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has been created.')
  end

  scenario 'Creating a ticket with invalid attributes' do
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has not been created.')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'Description must be longer than 10 characters' do
    fill_in 'Title', with: 'hello'
    fill_in 'Description', with: '123'
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has not been created.')
    expect(page).to have_content('Description is too short')
  end
end