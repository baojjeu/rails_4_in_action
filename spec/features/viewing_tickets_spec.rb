feature 'Viewing Tickets' do
  before do
    user = FactoryGirl.create(:user)

    sublime_text_3 = FactoryGirl.create(:project, name: 'Sublime Text 3')

    ticket = FactoryGirl.create(:ticket,
               project: sublime_text_3,
               title: 'Make it shiny!',
               description: 'GreatGreatGreatGreatGreat')

    ticket.update(user: user)

    visit '/'

    define_permission!(user, 'view', sublime_text_3)
    sign_in_as!(user)
  end

  scenario 'Viewing tickets for a given project' do
    click_link 'Sublime Text 3'

    expect(page).to have_content('Make it shiny!')
    expect(page).to_not have_content('Hey')

    click_link 'Make it shiny!'
    within('#ticket h2') do
      expect(page).to have_content('Make it shiny!')
    end

    expect(page).to have_content('GreatGreatGreatGreatGreat')
  end
end