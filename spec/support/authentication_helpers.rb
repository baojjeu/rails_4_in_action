module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/signin'

    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
  end

  RSpec.configure do |config|
    config.include AuthenticationHelpers, type: :feature
  end
end