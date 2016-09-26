require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test '댓글에 국회의원을 맨션합니다 focus!' do
    sign_in(users(:one))

    post project_comments_path(projects(:project1)), params: { comment: {
      body: "@#{congressmen(:congressman1).name} body"
    } }

    refute assigns(:comment).errors.any?

    assert assigns(:comment).mentions.first.congressman, congressmen(:congressman1)
  end

  test '이미 국회의원을 맨션한 댓글을 수정합니다 focus!' do
    assert comments(:comment1).mentioned? congressmen(:congressman1)
    refute comments(:comment1).mentioned? congressmen(:congressman2)
    assert comments(:comment1).mentioned? congressmen(:congressman3)


    sign_in(users(:one))

    patch comment_path(comments(:comment1)), params: { comment: {
      body: "@#{congressmen(:congressman2).name} @#{congressmen(:congressman3).name} body"
    } }

    refute assigns(:comment).errors.any?

    refute assigns(:comment).mentions.exists? congressman: congressmen(:congressman1)
    assert assigns(:comment).mentions.exists? congressman: congressmen(:congressman2)
    assert assigns(:comment).mentions.exists? congressman: congressmen(:congressman3)
  end
end
