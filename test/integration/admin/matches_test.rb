require 'test_helper'

class MatchesTest < ActionDispatch::IntegrationTest
  test '프로젝트에 의원을 매칭합니다.' do
    sign_in(users(:admin))
    post admin_project_matches_path(projects(:project1)), params: { match: { congressman_id: congressmen(:congressman1).id } }

    assert assigns(:match).persisted?
    assert_equal projects(:project1), assigns(:match).project
    assert_equal congressmen(:congressman1), assigns(:match).congressman
    assert assigns(:match).status.calling?
  end
end
