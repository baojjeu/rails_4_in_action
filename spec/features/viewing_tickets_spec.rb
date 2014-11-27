feature 'Viewing Tickets' do
  before do
    sublime_text_3 = FactoryGirl.create(:project, name: 'Sublime Text 3')
    FactoryGirl.create(:ticket,
       project: sublime_text_3,
       title: 'Make it shiny!',
       description: 'GreatGreatGreatGreatGreat')

    textmate = FactoryGirl.create(:project, name: 'Text mate')
    FactoryGirl.create(:ticket, project: textmate, title: 'Hey', description: 'YoYoYoYoYo')
    visit '/'
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