feature 'Deleting tickets' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) {
    ticket = FactoryGirl.create(:ticket, project: project)
    ticket.update(user: user)
    ticket
  }

  before do
    define_permission!(user, 'view', project)
    define_permission!(user, 'delete tickets', project)

    sign_in_as!(user)

    visit '/'

    click_link project.name
    click_link ticket.title
  end

  scenario 'Deleting a ticket' do
    click_link 'Delete Ticket'

    expect(page).to have_content('Ticket has been deleted.')
    expect(page).to_not have_content ticket.title
    expect(page.current_url).to eql(project_url(project))
  end
end