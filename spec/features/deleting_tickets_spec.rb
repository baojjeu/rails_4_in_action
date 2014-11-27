feature 'Deleting tickets' do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project) }

  before do
    visit '/'

    click_link project.name
    click_link ticket.title
  end

  scenario 'Deleting a ticket' do
    click_link 'Delete ticket'

    expect(page).to have_content('Ticket has been destroyed.')
    expect(page).to_not have_content ticket.title
    expect(page.current_url).to eql(project_url(project))
  end
end