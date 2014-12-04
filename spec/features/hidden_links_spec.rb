feature 'Hidden links' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }

  before do
    visit '/'
  end

  context 'Anonymous users' do
    scenario 'cannot see the New Project' do
      assert_no_link_for 'New Project'
    end

    scenario 'cannot see the Edit Project link' do
      visit project_path(project)

      assert_no_link_for 'Edit Project'
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)

      assert_no_link_for 'Delete Project'
    end
  end

  context 'Regular users' do
    before { sign_in_as!(user) }

    scenario 'cannot see the New Project' do
      assert_no_link_for 'New Project'
    end

    scenario 'cannot see the Edit Project link' do
      visit project_path(project)

      assert_no_link_for 'Edit Project'
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)

      assert_no_link_for 'Delete Project'
    end
  end

  context 'Admin users' do
    before { sign_in_as!(admin) }

    scenario 'can see the New Project' do
      assert_link_for 'New Project'
    end

    scenario 'can see the Edit Project link' do
      visit project_path(project)

      assert_link_for 'Edit Project'
    end

    scenario 'can see Delete Project link' do
      visit project_path(project)

      assert_link_for 'Delete Project'
    end
  end
end