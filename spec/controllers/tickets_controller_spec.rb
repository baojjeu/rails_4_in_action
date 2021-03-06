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

    def cannot_edit_tickets!
      expect(response).to redirect_to(project)
      message = 'You cannot edit tickets on this project.'
      expect(flash[:error]).to eql(message)
    end

    def cannot_delete_tickets!
      expect(response).to redirect_to(project)
      message = 'You cannot delete tickets on this project.'
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

    it 'cannot edit a ticket without permission' do
      get :edit, id: ticket.id, project_id: project.id
      cannot_edit_tickets!
    end

    it 'cannot update a ticket without permission' do
      put :update, id: ticket.id, project_id: project.id, ticket: {}
      cannot_edit_tickets!
    end

    it 'cannot delete a ticket without permission' do
      delete :destroy, id: ticket.id, project_id: project.id
      cannot_delete_tickets!
    end
  end
end