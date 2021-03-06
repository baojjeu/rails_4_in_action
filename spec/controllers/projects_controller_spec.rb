RSpec.describe ProjectsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  before { sign_in(user) }

  context 'standard users' do

    { new:     :get,
      edit:    :get,
      create:  :post,
      update:  :put,
      destroy: :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        send(method, action, id: FactoryGirl.create(:project))
        expect(response).to redirect_to(root_url)
        expect(flash[:error]).to eql('You must be an admin to do that.')
      end
    end
  end

  it 'displays an error for a missing project' do
    get :show, id: 'not-here'

    expect(response).to redirect_to(projects_path)
    message = 'The project you were looking for could not be found.'

    expect(flash[:error]).to eql(message)
  end

  it 'cannot access the show action without permission' do
    p = FactoryGirl.create(:project)
    get :show, id: p.id

    expect(flash[:error]).to eql('The project you were looking for could not be found.')
  end
end