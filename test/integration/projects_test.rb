require 'test_helper'

class ProjectsTest < ActionDispatch::IntegrationTest
  test '프로젝트를 만듭니다.' do
    sign_in(users(:one))
    post projects_path, params: {project: {
      title: 'title', body: 'body',
      proposal_id: proposals(:proposal1),
      attachments_attributes: [
        {source: fixture_file('files/sample.pdf')}
      ]
    }}

    assert assigns[:project].persisted?
    attachment = assigns[:project].attachments.first
    assert_equal 'sample.pdf', attachment.name
  end
end
