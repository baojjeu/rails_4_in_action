RSpec.describe User, :type => :model do
  describe 'passwords' do
    it 'needs a password and confirmation to save' do
      u = User.create(name: 'Baozi', email: "steve@example.com")
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
                      email: "steve@example.com",
                      password: 'abc123456',
                      password_confirmation: 'abc123457')
      expect(u).to_not be_valid
    end
  end

  describe 'authenticate' do
    let(:user) { User.create(name: 'Baozi',
                             email: "steve@example.com",
                             password: 'abc123456',
                             password_confirmation: 'abc123456') }

    it 'authenticate with a correct password' do
      expect(user.authenticate('abc123456')).to be
    end

    it 'does not authenticate with a incorrect password' do
      expect(user.authenticate('abc33333')).to_not be
    end
  end

  describe 'emails' do
    it 'requires an email' do
      u = User.new(name: "steve",
                   password: "hunter2",
                   password_confirmation: "hunter2")
      u.save
      expect(u).to_not be_valid

      u.email = "steve@example.com"
      u.save
      expect(u).to be_valid
    end
  end
end
