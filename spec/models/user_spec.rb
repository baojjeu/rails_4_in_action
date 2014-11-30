require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'passwords' do
    it 'needs a password and confirmation to save' do
      u = User.create(name: 'Baozi')
      u.save
      expect(u).to_not be_valid

      u.password = 'password'
      u.password_confirmation = ''
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = 'password'
      u.save
      expect(u).to be_valid
    end

    it 'needs password and confirmation to match' do
      u = User.create(name: 'baozi',
                      password: 'abc123456',
                      password_confirmation: 'abc123457')
      expect(u).to_not be_valid
    end
  end

  describe 'authenticate' do
    let(:user) { User.create(name: 'Baozi',
                             password: 'abc123456',
                             password_confirmation: 'abc123456') }

    it 'authenticate with a correct password' do
      expect(user.authenticate('abc123456')).to be
    end

    it 'does not authenticate with a incorrect password' do
      expect(user.authenticate('abc33333')).to_not be
    end
  end
end
