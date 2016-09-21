require 'test_helper'

class ProposalsTest < ActionDispatch::IntegrationTest
  test '제안만들때 파일업로드가 됩니다.' do
    sign_in(users(:one))
    post proposals_path, params: {proposal: {
      title: 'title', body: 'body',
      proposal_attachments_attributes: [
        {source: fixture_file('files/sample.pdf')}
      ]
    }}

    assert assigns[:proposal].persisted?
    attachment = assigns[:proposal].proposal_attachments.first
    assert_equal 'sample.pdf', attachment.name
  end
end
