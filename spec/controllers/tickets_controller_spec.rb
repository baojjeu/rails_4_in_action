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

  context 'with permission to view the project' do
    before do
      sign_in(user)
      define_permission!(user, 'view', project)
    end

    def cannot_create_tickets!
      expect(response).to redirect_to(project)
      message = 'You cannot create tickets on this project.'
      expect(flash[:error]).to eql(message)
    end

    it 'cannot begin to create a ticket' do
      get :new, project_id: project.id
      cannot_create_tickets!
    end

    it 'cannot create a ticket without permission' do
      post :create, project_id: project.id
      cannot_create_tickets!
    end
  end
end