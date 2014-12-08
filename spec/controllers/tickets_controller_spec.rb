RSpec.describe TicketsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context 'Standard users' do
    before { sign_in(user) }

    it 'cannot access a ticket for a project' do
      get :show, id: ticket.id, project_id: project.id

      expect(response).to redirect_to root_path
      expect(flash[:error]).to eql('The project you were looking for could not be found.')
    end
  end
end