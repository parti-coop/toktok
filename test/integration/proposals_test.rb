require 'test_helper'

class ProposalsTest < ActionDispatch::IntegrationTest
  test '제안 만들때 파일업로드가 됩니다.' do
    sign_in(users(:one))
    post proposals_path, params: {proposal: {
      title: 'title', body: 'body',
      proposer_name: 'pnanem',
      proposer_email: 'pemail',
      proposer_phone: 'pphone',
      attachments_attributes: [
        {source: fixture_file('files/sample.pdf')}
      ]
    }}

    assert assigns(:proposal).persisted?
    attachment = assigns(:proposal).attachments.first
    assert_equal 'sample.pdf', attachment.name
  end

  test '로그인하고 제안 만듭니다' do
    sign_in(users(:one))
    post proposals_path, params: {proposal: {
      title: 'title', body: 'body',
      proposer_name: 'pname',
      proposer_email: 'pemail',
      proposer_phone: 'pphone'
    }}

    assert assigns(:proposal).persisted?

    assert_equal users(:one), assigns(:proposal).user
    assert_equal 'pname', assigns(:proposal).proposer_name
    assert_equal 'pemail', assigns(:proposal).proposer_email
    assert_equal 'pphone', assigns(:proposal).proposer_phone
  end

  test '로그인하지 않고 제안 만듭니다' do
    post proposals_path, params: {proposal: {
      title: 'title', body: 'body',
      proposer_name: 'pname',
      proposer_email: 'pemail',
      proposer_phone: 'pphone'
    }}

    assert assigns(:proposal).persisted?

    assert_nil assigns(:proposal).user
    assert_equal 'pname', assigns(:proposal).proposer_name
    assert_equal 'pemail', assigns(:proposal).proposer_email
    assert_equal 'pphone', assigns(:proposal).proposer_phone
  end
end
