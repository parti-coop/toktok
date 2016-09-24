require 'test_helper'

class ParticipationTest < ActionDispatch::IntegrationTest
  test '프로젝트에 시민이 참여합니다' do
    sign_in(users(:one))
    refute projects(:project1).participant? users(:one)

    post project_participations_path(project_id: projects(:project1))

    assert projects(:project1).participant? users(:one)
  end

  test '시민이 참여를 철회합니다' do
    sign_in(users(:two))
    assert projects(:project1).participant? users(:two)

    delete cancel_project_participations_path(project_id: projects(:project1))

    refute projects(:project1).participant? users(:two)
  end
end
