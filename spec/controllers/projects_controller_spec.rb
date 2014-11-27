RSpec.describe ProjectsController, :type => :controller do
  it 'displays an error for a missing project' do
    get :show, id: 'not-here'

    expect(response).to redirect_to(projects_path)
    message = 'The project you were looking for could not be found.'

    expect(flash[:error]).to eql(message)
  end
end