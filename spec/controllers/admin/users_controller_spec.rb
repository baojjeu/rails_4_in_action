RSpec.describe Admin::UsersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  context 'Standard user' do
    before { sign_in(user) }

    it 'is not able to access the index action' do
      get 'index'

      expect(response).to redirect_to(root_path)
      expect(flash[:error]).to eql('You must be an admin to do that.')
    end
  end
end
